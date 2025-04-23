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
    ("20", "남성"): 2,  # 현실적으로 초저가 중고차를 선호할 가능성 높음
    ("20", "여성"): 2,  # 동일 — 오래된 연식, 초저가 우선 고려
    ("30", "남성"): 1,  # 실속형 대중차 — 약간의 여유 있으면서도 가성비 중시
    ("30", "여성"): 4,  # 안전성·유지비 중시 → 중저가+연식 오래됨
    ("40", "남성"): 0,  # 여유 있는 프리미엄 지향 — 신차급 고가
    ("40", "여성"): 3,  # 합리적이면서도 최신차 → 고급보다는 실속형 최신차
    ("50", "남성"): 0,  # 고가, 짧은 주행거리 → 신차 수준
    ("50", "여성"): 1,  # 실속형 최신 중고차에 가까운 군
    ("60", "남성"): 3,  # 최신 연식이지만 중고가 → 관리 쉬운 차량
    ("60", "여성"): 3,  # 실속형 최신차 → 부담 덜한 중고가 최신차
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
            return int(min_b) - 250 , int(max_b) + 250  # 만원 단위 → 원화 단위
    except Exception as e:
        print(f"budget parsing error: {e}")
    return 0, 99999  # 파싱 실패하면 넓게 허용



# 0번	신차급 고가 프리미엄 차량군
# 1번	실속형 준신차, 주행거리 적당, 대중적인 구성
# 2번	오래된 연식 + 높은 주행거리의 초저가 중고차
# 3번	최신 연식이지만 고급형보다는 실속형에 가까운 중간 가격대
# 4번	노후화된 중저가 차량, 주행거리 많음




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

    #  목적(purpose)에 따라 주행거리 추가 필터링
    if purpose == "travel":
        filtered = filtered[filtered['주행거리_clean'] <= 100000]
    elif purpose == "nearby":
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


