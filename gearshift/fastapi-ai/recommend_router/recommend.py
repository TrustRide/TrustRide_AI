from fastapi import FastAPI, Form, Request
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.responses import JSONResponse
from fastapi import HTTPException, APIRouter


import joblib
import numpy as np
import pandas as pd
import random




app = FastAPI()
templates = Jinja2Templates(directory="templates")


router = APIRouter(
    tags=["recommend"],
)



# --------------------------------------
# 1. 모델 및 인코더 로딩
# --------------------------------------
model = joblib.load("recommend_router/random_forest_model.pkl")
car_type_le = joblib.load("recommend_router/label_encoder.pkl")
brand_le = joblib.load("recommend_router/brand_encoder.pkl")

# --------------------------------------
# 2. 차량 정보 로드 및 전처리
# --------------------------------------
car_df = pd.read_csv("recommend_router/car_data.csv")

car_df['가격'] = (
    car_df['가격']
    .astype(str)
    .str.replace(',', '')
    .str.replace('만원', '')
    .astype(float)
)

# 연식 정제
def clean_year(value):
    if isinstance(value, str) and value[:2].isdigit():
        yy = int(value[:2])
        return 2000 + yy if yy <= 25 else 1900 + yy
    elif isinstance(value, str) and value[:4].isdigit():
        return int(value[:4])
    return None

car_df['연식_clean'] = car_df['연식'].apply(clean_year)


# --------------------------------------
# 3. 유틸 함수
# --------------------------------------
def parse_budget_range(budget_str):
    """
    '0-1500'과 같은 문자열을 받아서 (최소, 최대) 예산(만원 단위)으로 변환
    """
    try:
        if '-' in budget_str:
            min_b, max_b = budget_str.split('-')
            return int(min_b) , int(max_b)
    except:
        pass
    return 0, 99999999

# --------------------------------------
# 4. 설문 전처리 함수 (모델 입력 생성)
# --------------------------------------
def preprocess_form_input(form):

    budget_str = form.get('budget', '0-1500')
    budget_min, budget_max = parse_budget_range(budget_str)

    passenger = form.get('passenger', '1')
    if passenger == "2+" and budget_min < 1000:
        budget_min = 1000

    purpose = form.get('purpose', 'commute')
    purpose_map = {"commute": 15000, "travel": 25000, "nearby": 8000}
    mileage = purpose_map.get(purpose, 12000)

    brand_type = form.get('brand_type', '상관없음')

    year_pref = form.get('year_preference', 'any')
    if year_pref == '5':
        year_clean = 2021
        year_group = 0
    else:
        year_clean = 2015
        year_group = 1

    avg_mileage = mileage / (2025 - year_clean + 1)


    brand_label_avg = int(car_df['브랜드_label'].mean().round())

    model_vector = [[
        ((budget_min + budget_max) // 2 ),
        year_clean,
        year_group,
        mileage,
        avg_mileage,
        brand_label_avg
    ]]

    # 문자열로 반환
    return model_vector, budget_min, budget_max, brand_type


# --------------------------------------
# 5. 추천 로직
# --------------------------------------

def get_top3_recommendations(input_vector, budget_min, budget_max, brand_type):
    X_input = [row[:7] for row in input_vector]
    proba = model.predict_proba(X_input)[0]
    top3_indices = np.argsort(proba)[::-1][:3]
    top3_labels = [car_type_le.inverse_transform([i])[0] for i in top3_indices]

    results = []
    for label in top3_labels:
        filtered = car_df[
            (car_df['차종'] == label) &
            (car_df['가격'] >= budget_min) &
            (car_df['가격'] <= budget_max) &
            (car_df['연식_clean'] >= input_vector[0][2] - 1)
            ]

        if brand_type == '국산':
            filtered = filtered[filtered['국산/수입'] == '국산']
        elif brand_type == '수입':
            filtered = filtered[filtered['국산/수입'] == '수입']

        if not filtered.empty:
            match = filtered.sample(1, random_state=random.randint(0, 10000))  # 랜덤 추출
            car = match.iloc[0]
            results.append({
                '차종': car['차종'],
                '모델정보': f"{car['브랜드']} {car['모델명']} {car['트림'] or ''}".strip(),
                '이미지': car.get('이미지'),
                '상세링크': car.get('상세링크'),
                '가격': int(car.get('가격'))
            })

    return results




# --------------------------------------
# 6. 라우팅
# --------------------------------------


@router.post("/recommend", response_class=JSONResponse)
async def recommend_car(
        brand_type: str = Form(...),
        budget: str = Form(...),
        purpose: str = Form(...),
        passenger: str = Form(...),
        year_preference: str = Form(...)
):

    form = {
        "brand_type": brand_type,
        "budget": budget,
        "purpose": purpose,
        "passenger": passenger,
        "year_preference": year_preference
    }

    input_vector, budget_min, budget_max, brand_type = preprocess_form_input(form)
    top3 = get_top3_recommendations(input_vector, budget_min, budget_max, brand_type)

    # UTF-8 명시적으로 포함
    return JSONResponse(
        content=top3,
        media_type="application/json; charset=utf-8"
    )

