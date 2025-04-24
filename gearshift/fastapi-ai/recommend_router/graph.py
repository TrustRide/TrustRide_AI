import pandas as pd
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
import joblib

# 한글 폰트 설정
plt.rcParams['font.family'] = 'Malgun Gothic'
plt.rcParams['axes.unicode_minus'] = False

# 1. 데이터 로드
df = pd.read_csv('car_data_clustered.csv')

# 2. 클러스터별 요약 생성
cluster_summary = {
    0: "신차급 고가 프리미엄 차량군",
    1: "실속형 준신차, 주행거리 적당, 대중적인 구성",
    2: "오래된 연식 + 높은 주행거리의 초저가 중고차",
    3: "최신 연식이지만 고급형보다는 실속형에 가까운 중간 가격대",
    4: "노후화된 중저가 차량, 주행거리 많음"
}

# 3. 특징 추출 (저장 당시 사용한 컬럼 순서로)
feature_cols = ['가격', '연식_clean', '주행거리_clean']
X = df[feature_cols]

# 4. 스케일러 로딩 및 적용
scaler = joblib.load('scaler.pkl')
X_scaled = scaler.transform(X)

# 5. PCA 2D 변환
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)

# 6. 레이블
y = df['cluster_label']

# 7. 시각화 (확대된 시야 적용)
plt.figure(figsize=(10, 7))

# 축 범위 계산 및 확대 마진 적용
x_min, x_max = X_pca[:, 0].min(), X_pca[:, 0].max()
y_min, y_max = X_pca[:, 1].min(), X_pca[:, 1].max()
x_margin = (x_max - x_min) * 0.2
y_margin = (y_max - y_min) * 0.2

for cluster_num in sorted(y.unique()):
    plt.scatter(
        X_pca[y == cluster_num, 0],
        X_pca[y == cluster_num, 1],
        label=f'Cluster {cluster_num} - {cluster_summary[cluster_num]}',
        alpha=0.7,
        edgecolors='k'
    )

plt.title('PCA 기반 자동차 클러스터 시각화')
plt.xlabel('PCA 1 (신차급에 가까운 차량)')
plt.ylabel('PCA 2 (비표준적인 조합의 차량)')
plt.xlim(x_min - x_margin, x_max + x_margin)
plt.ylim(y_min - y_margin, y_max + y_margin)
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()


