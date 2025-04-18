# recommend_cluster_router.py
from fastapi import FastAPI, Form
from fastapi.responses import JSONResponse
from fastapi.templating import Jinja2Templates
from fastapi import APIRouter
import pandas as pd
import joblib
import random

app = FastAPI()
router = APIRouter(tags=["recommend"])

templates = Jinja2Templates(directory="templates")

# 모델 로딩
kmeans = joblib.load("recommend_router/kmeans_model.pkl")
scaler = joblib.load("recommend_router/scaler.pkl")

# 데이터 로딩
car_df = pd.read_csv("recommend_router/car_data_clustered.csv")


# 연령대+성별 매핑표 (k=5 기준)
age_gender_cluster_map = {
    ("20", "남성"): 1,  # 사회초년생 ➔ 초저가 고주행차
    ("20", "여성"): 1,  # 사회초년생 ➔ 초저가 고주행차
    ("30", "남성"): 0,  # 실속형 중고차 선호
    ("30", "여성"): 3,  # 준신차급 중형차 선호
    ("40", "남성"): 3,  # 준신차급 중형차 or 신차급 SUV
    ("40", "여성"): 3,  # 준신차급 중형차 선호
    ("50", "남성"): 2,  # 신차급 SUV/대형차 선호
    ("50", "여성"): 2,  # 신차급 SUV/대형차 선호
    ("60", "남성"): 2,  # 신차급 SUV/대형차 (장거리 주행)
    ("60", "여성"): 2,  # 신차급 SUV/대형차 (장거리 주행)
}

# 목적 → 예상 주행거리 맵핑
purpose_mileage_map = {
    "commute": 15000,    # 출퇴근
    "travel": 25000,     # 장거리 여행
    "nearby": 8000       # 근거리
}

# 예산 파싱 함수 (수정 버전)
def parse_budget_range(budget_str):
    try:
        if budget_str == "0-9999":
            return 0, 99999  # "상관없음" → 무제한 허용
        elif '-' in budget_str:
            min_b, max_b = budget_str.split('-')
            return int(min_b) - 500 , int(max_b) + 500  # 만원 단위 → 원화 단위
    except Exception as e:
        print(f"budget parsing error: {e}")
    return 0, 99999  # 파싱 실패하면 넓게 허용




# 0번	중고차 (가성비 세단/SUV)
# 1번	초저가 고주행차 (연습용/사회초년생)
# 2번	신차급 SUV/대형차 (4000만원 이상)
# 3번	준신차급 중형차/SUV (2000~3000만원대)
# 4번	슈퍼카/럭셔리 수입차 (5000만원 이상)


# recommend_by_cluster 함수 수정 부분

def recommend_by_cluster(age, gender, budget_min, budget_max, brand_type, purpose):

    age = str(age)
    cluster = age_gender_cluster_map.get((age, gender))
    if cluster is None:
        cluster = random.choice([0, 1, 2, 3, 4])



    filtered = car_df[
        (car_df['cluster_label'] == cluster) &
        (car_df['가격'] >= budget_min) &
        (car_df['가격'] <= budget_max)
        ]

    if brand_type == "국산":
        filtered = filtered[filtered['국산/수입'] == '국산']
    elif brand_type == "수입":
        filtered = filtered[filtered['국산/수입'] == '수입']

    # 🚗 목적(purpose)에 따라 주행거리 추가 필터링
    if purpose == "travel":
        filtered = filtered[filtered['주행거리_clean'] <= 100000]
    elif purpose == "nearby":
        pass

    # ➡ 수정: 특정 나이대(30 - 남성) + 예산 5000 이상일 때만 4번 클러스터로 변경
    if age == "30" and gender == "남성" and budget_min >= 5000:
        cluster = 4


    if not filtered.empty:
        selected = filtered.sample(min(3, len(filtered)), random_state=random.randint(0, 10000))
        results = []
        for idx, row in selected.iterrows():
            results.append({
                "차종": row['차종'],
                "모델정보": f"{row['브랜드']} {row['모델명']} {row['트림'] or ''}".strip(),
                "가격": int(row['가격']),
                "이미지": row.get('이미지'),
                "상세링크": row.get('상세링크'),
            })
        return results
    else:
        fallback = car_df[car_df['cluster_label'] == cluster]
        if not fallback.empty:
            selected = fallback.sample(min(3, len(fallback)), random_state=random.randint(0, 10000))
            return [{
                "차종": row['차종'],
                "모델정보": f"{row['브랜드']} {row['모델명']} {row['트림'] or ''}".strip(),
                "가격": int(row['가격']),
                "이미지": row.get('이미지'),
                "상세링크": row.get('상세링크'),
            } for idx, row in selected.iterrows()]
        else:
            return []



# FastAPI POST 엔드포인트

@router.post("/recommend", response_class=JSONResponse)
async def recommend_car(
        age: str = Form(...),
        gender: str = Form(...),
        budget: str = Form(...),
        purpose: str = Form(...),
        brand_type: str = Form(...)
):
    # 예산 파싱
    budget_min, budget_max = parse_budget_range(budget)

    # 추천 차량 추출
    top3 = recommend_by_cluster(age, gender, budget_min, budget_max, brand_type, purpose)

    return JSONResponse(
        content=top3,
        media_type="application/json; charset=utf-8"
    )


