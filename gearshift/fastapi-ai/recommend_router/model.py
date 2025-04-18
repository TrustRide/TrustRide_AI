# kmeans_model_train.py
import pandas as pd
import re
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import joblib

# ------------------------------------
# 1. 데이터 로드
# ------------------------------------
df = pd.read_csv("car_data.csv")

# ------------------------------------
# 2. 데이터 전처리
# ------------------------------------

# 가격 전처리
df['가격'] = (
    df['가격']
    .astype(str)
    .str.replace(',', '')
    .str.replace('만원', '')
    .astype(float)
)

# 연식 전처리
def clean_year(value):
    if isinstance(value, str) and re.match(r'^\d{2}', value):
        yy = int(value[:2])
        return 2000 + yy if yy <= 25 else 1900 + yy
    elif isinstance(value, str) and re.match(r'^\d{4}', value):
        return int(value[:4])
    return None

df['연식_clean'] = df['연식'].apply(clean_year)

# 주행거리 전처리
def clean_mileage(value):
    if isinstance(value, str):
        return int(value.replace(',', '').replace('km', '').replace('KM', '').strip())
    return value

df['주행거리_clean'] = df['주행거리'].apply(clean_mileage)

# 사용할 컬럼만
df = df.dropna(subset=['가격', '연식_clean', '주행거리_clean'])
X = df[['가격', '연식_clean', '주행거리_clean']]

# ------------------------------------
# 3. 표준화 (StandardScaler)
# ------------------------------------
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# ------------------------------------
# 4. KMeans 군집화
# ------------------------------------
kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
df['cluster_label'] = kmeans.fit_predict(X_scaled)

# ------------------------------------
# 5. 결과 저장
# ------------------------------------
joblib.dump(kmeans, 'kmeans_model.pkl')       # 모델 저장
joblib.dump(scaler, 'scaler.pkl')              # 스케일러 저장
df.to_csv('car_data_clustered.csv', index=False)  # 군집 컬럼 포함 데이터 저장

print("✅ 모델 학습 및 저장 완료!")
