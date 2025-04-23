
import pandas as pd
import matplotlib.pyplot as plt
import re
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
from sklearn.preprocessing import MinMaxScaler

# [추가] 한글 깨짐 방지 (Windows 기준 '맑은 고딕' 폰트 적용)
plt.rcParams['font.family'] = 'Malgun Gothic'
plt.rcParams['axes.unicode_minus'] = False

# 1. 데이터 로드
df = pd.read_csv("car_data.csv")

# 2. 데이터 전처리
df['가격'] = (
    df['가격']
    .astype(str)
    .str.replace(',', '')
    .str.replace('만원', '')
    .astype(float)
)

def clean_year(value):
    if isinstance(value, str) and re.match(r'^\d{2}', value):
        yy = int(value[:2])
        return 2000 + yy if yy <= 25 else 1900 + yy
    elif isinstance(value, str) and re.match(r'^\d{4}', value):
        return int(value[:4])
    return None

df['연식_clean'] = df['연식'].apply(clean_year)

def clean_mileage(value):
    if isinstance(value, str):
        return int(value.replace(',', '').replace('km', '').replace('KM', '').strip())
    return value

df['주행거리_clean'] = df['주행거리'].apply(clean_mileage)

# 사용할 컬럼만


base_columns = ['가격', '연식_clean', '주행거리_clean']
X = df[base_columns]


# 3. 표준화
scaler = MinMaxScaler()
X_scaled = scaler.fit_transform(X)


# 4. 클러스터 수를 바꿔가며 실루엣 점수 계산
silhouette_scores = []
k_range = range(2, 11)  # k = 2 ~ 10

for k in k_range:
    kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
    cluster_labels = kmeans.fit_predict(X_scaled)
    score = silhouette_score(X_scaled, cluster_labels)
    silhouette_scores.append(score)
    print(f"k={k}, 실루엣 점수={score:.4f}")

# 5. 꺾은선 그래프 그리기
plt.figure(figsize=(8,5))
plt.plot(k_range, silhouette_scores, marker='o')
plt.title('k값에 따른 실루엣 점수')
plt.xlabel('k (클러스터 수)')
plt.ylabel('실루엣 점수')
plt.xticks(k_range)
plt.grid(True)
plt.show()





