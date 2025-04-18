import pandas as pd
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from mpl_toolkits.mplot3d import Axes3D  # 3D 그래프를 위해 필요

# 1. 한글 깨짐 방지 설정
plt.rcParams['font.family'] = 'Malgun Gothic'  # Windows '맑은 고딕'
plt.rcParams['axes.unicode_minus'] = False

# 2. 데이터 로드
df = pd.read_csv("car_data_clustered.csv")

# 3. PCA를 이용한 클러스터 분포 시각화 (2D)

# 사용 컬럼만
X = df[['가격', '연식_clean', '주행거리_clean']]

# 표준화
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# PCA 2D 변환
pca_2d = PCA(n_components=2)
X_pca_2d = pca_2d.fit_transform(X_scaled)

# 2D 시각화
plt.figure(figsize=(8,6))
for cluster in sorted(df['cluster_label'].unique()):
    plt.scatter(
        X_pca_2d[df['cluster_label'] == cluster, 0],
        X_pca_2d[df['cluster_label'] == cluster, 1],
        label=f'클러스터 {cluster}',
        alpha=0.7
    )
plt.title('PCA 2D 변환을 통한 클러스터 분포')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.legend()
plt.grid(True)
plt.show()

# 4. PCA를 이용한 클러스터 분포 시각화 (3D)

# PCA 3D 변환
pca_3d = PCA(n_components=3)
X_pca_3d = pca_3d.fit_transform(X_scaled)

# 3D 시각화
fig = plt.figure(figsize=(10,8))
ax = fig.add_subplot(111, projection='3d')

for cluster in sorted(df['cluster_label'].unique()):
    ax.scatter(
        X_pca_3d[df['cluster_label'] == cluster, 0],
        X_pca_3d[df['cluster_label'] == cluster, 1],
        X_pca_3d[df['cluster_label'] == cluster, 2],
        label=f'클러스터 {cluster}',
        alpha=0.7
    )

ax.set_title('PCA 3D 변환을 통한 클러스터 분포')
ax.set_xlabel('PC1')
ax.set_ylabel('PC2')
ax.set_zlabel('PC3')
ax.legend()
plt.show()
