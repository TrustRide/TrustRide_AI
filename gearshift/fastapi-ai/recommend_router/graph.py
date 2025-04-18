import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

# 1. 한글 깨짐 방지 설정
plt.rcParams['font.family'] = 'Malgun Gothic'  # Windows '맑은 고딕'
plt.rcParams['axes.unicode_minus'] = False

# 2. 데이터 로드
df = pd.read_csv("car_data_clustered.csv")

# 3. 사용 컬럼 선택
X = df[['가격', '연식_clean', '주행거리_clean']]

# 4. 표준화
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# 5. PCA 변환 (2차원)
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)

# 6. 2D 시각화
plt.figure(figsize=(10,7))
for cluster in sorted(df['cluster_label'].unique()):
    plt.scatter(
        X_pca[df['cluster_label'] == cluster, 0],
        X_pca[df['cluster_label'] == cluster, 1],
        label=f'클러스터 {cluster}',
        alpha=0.7
    )

plt.title('PCA 2D 변환을 통한 클러스터 분포 (k=10)')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.legend()
plt.grid(True)
plt.show()
