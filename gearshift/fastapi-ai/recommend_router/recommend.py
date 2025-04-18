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


# 연령대+성별 매핑표
age_gender_cluster_map = {
    ("20", "남성"): 2,
    ("20", "여성"): 2,
    ("30", "남성"): 0,
    ("30", "여성"): 2,
    ("40", "남성"): 1,
    ("40", "여성"): 0,
    ("50", "남성"): 1,
    ("50", "여성"): 1,
    ("60", "남성"): 1,
    ("60", "여성"): 1,
}

# 목적 → 예상 주행거리 맵핑
purpose_mileage_map = {
    "commute": 15000,    # 출퇴근
    "travel": 25000,     # 장거리 여행
    "nearby": 8000       # 근거리
}

# 예산 파싱 함수
def parse_budget_range(budget_str):
    try:
        if '-' in budget_str:
            min_b, max_b = budget_str.split('-')
            return int(min_b), int(max_b)
    except:
        pass
    return 0, 99999999


# 0번	중간 가격대, 준수한 연식, 가성비형
# 1번	고가격, 신차급, 짧은 주행거리
# 2번	초저가, 오래된 연식, 높은 주행거리

def recommend_by_cluster(age, gender, budget_min, budget_max, brand_type, purpose):
    cluster = age_gender_cluster_map.get((age, gender))
    if cluster is None:
        cluster = random.choice([0, 1, 2])  # (k=3이니까)

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
        # 주행거리 10만 km 이하 차량만 추천
        filtered = filtered[filtered['주행거리_clean'] <= 100000]
    elif purpose == "nearby":
        # nearby는 특별히 추가 주행거리 조건 없음 (오래된 차도 추천 허용)
        pass

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
        # fallback
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


