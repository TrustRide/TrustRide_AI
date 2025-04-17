import pandas as pd
import re
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
import joblib

# ------------------------------------
# 1. 데이터 로드 및 전처리
# ------------------------------------
df = pd.read_csv("car_data.csv")

# 가격 전처리
df['가격'] = df['가격'].astype(str).str.replace(',', '').str.replace('만원', '').astype(int)

# 연식 전처리
def clean_year(value):
    if isinstance(value, str) and re.match(r'\d{2}', value):
        yy = int(value[:2])
        return 2000 + yy if yy <= 25 else 1900 + yy
    elif isinstance(value, str) and re.match(r'\d{4}', value):
        return int(value[:4])
    return None

df['연식_clean'] = df['연식'].apply(clean_year)
df['연식_group'] = df['연식_clean'].apply(lambda y: 0 if y >= 2020 else (1 if y >= 2010 else 2))

# 인코딩
brand_le = LabelEncoder()
df['브랜드_label'] = brand_le.fit_transform(df['브랜드'])


car_type_le = LabelEncoder()
df['차종_label'] = car_type_le.fit_transform(df['차종'])

# 주행거리 정제
def clean_mileage(value):
    if isinstance(value, str):
        return int(value.replace(',', '').replace('km', '').replace('KM', '').strip())
    return value

df['주행거리_clean'] = df['주행거리'].apply(clean_mileage)
df['평균주행거리'] = df['주행거리_clean'] / (2025 - df['연식_clean'] + 1)

# 결측치 제거
df = df.dropna(subset=[
    '연료', '연식_clean', '주행거리_clean', '차종', '브랜드_label'
])

# ------------------------------------
# 2. 학습 데이터 구성 (브랜드_국산 제거)
# ------------------------------------
feature_cols = [
     '가격', '연식_clean', '연식_group',
    '주행거리_clean', '평균주행거리', '브랜드_label'  # ← 포함 OK
]
X = df[feature_cols]
y = df['차종_label']

X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=42)

# ------------------------------------
# 3. 모델 학습
# ------------------------------------
model = RandomForestClassifier(
    n_estimators=100,
    class_weight='balanced',
    random_state=42
)
model.fit(X_train, y_train)

# ------------------------------------
# 4. 학습 결과 저장
# ------------------------------------
joblib.dump(model, "random_forest_model.pkl")
joblib.dump(car_type_le, "label_encoder.pkl")
joblib.dump(brand_le, "brand_encoder.pkl")

# 최종 전처리된 CSV도 덮어쓰기
df.to_csv("car_data.csv", index=False)


# ------------------------------------
# 5. 설문 입력값 → 입력 벡터 변환 함수
# ------------------------------------
def adjust_budget_by_passenger(budget: int, passenger: str) -> int:
    if passenger == "2+" and budget < 1000:
        return 1000
    return budget

def purpose_to_mileage(purpose: str) -> int:
    return {
        "commute": 15000,
        "travel": 25000,
        "nearby": 8000
    }.get(purpose, 12000)

def brand_type_to_flag(value: str) -> int:
    if value == '국산':
        return 1
    elif value == '수입':
        return 0
    return None  # '상관없음'

def preprocess_form_input(form):
    try:
        raw_budget = int(form.get('budget', 1500))
    except:
        raw_budget = 1500

    passenger = form.get('passenger', '1')
    budget = adjust_budget_by_passenger(raw_budget, passenger) 

    purpose = form.get('purpose', 'commute')
    mileage = purpose_to_mileage(purpose)

    brand_type = form.get('brand_type', 'any')

    year_pref = form.get('year_preference', 'any')
    if year_pref == '5':
        year_clean = 2021
        year_group = 0
    else:
        year_clean = 2015
        year_group = 1

    avg_mileage = mileage / (2025 - year_clean + 1)


    brand_label_avg = int(df['브랜드_label'].mean().round())

    return [[
        budget,
        year_clean,
        year_group,
        mileage,
        avg_mileage,
        brand_label_avg  # 대표값
    ]]




