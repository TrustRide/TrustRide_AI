# 필요한 패키지 import
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from sklearn.preprocessing import MinMaxScaler

# 한글 폰트 설정
plt.rcParams['font.family'] = 'Malgun Gothic'
plt.rcParams['axes.unicode_minus'] = False

# 데이터 로드
df = pd.read_csv("car_data_clustered.csv")

# 사용할 컬럼
X = df[['가격', '연식_clean', '주행거리_clean']]

# 스케일링
scaler = MinMaxScaler()
X_scaled = scaler.fit_transform(X)

# PCA 3차원 변환
pca = PCA(n_components=3)
X_pca = pca.fit_transform(X_scaled)

# 레이블
y = df['cluster_label']

# 3D 시각화
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

for cluster_num in sorted(y.unique()):
    ax.scatter(
        X_pca[y == cluster_num, 0],
        X_pca[y == cluster_num, 1],
        X_pca[y == cluster_num, 2],
        label=f'Cluster {cluster_num}',
        alpha=0.7,
        edgecolors='k'
    )

ax.set_title('PCA 기반 자동차 클러스터 3D 시각화')
ax.set_xlabel('PCA 1')
ax.set_ylabel('PCA 2')
ax.set_zlabel('PCA 3')
ax.legend()
plt.tight_layout()
plt.show()
