import pandas as pd
from langchain_community.vectorstores import Chroma
from langchain_upstage import UpstageEmbeddings
from langchain_core.documents import Document
from langchain_text_splitters import RecursiveCharacterTextSplitter
import os

CHROMA_DB_DIR = "./chroma_db"
DATA_PATH = os.path.join(os.path.dirname(__file__), "car_data.csv")  # 절대경로 기반 처리

# CSV 로드 및 전처리
encoding_list = ["utf-8", "utf-8-sig", "cp949", "euc-kr"]
df = None
for enc in encoding_list:
    try:
        df = pd.read_csv(DATA_PATH, encoding=enc)
        print(f"✅ CSV 로딩 성공: 인코딩={enc}")
        break
    except Exception as e:
        print(f"❌ CSV 로딩 실패 (encoding={enc}): {e}")
if df is None:
    raise ValueError("❌ CSV 파일 로딩 실패: 인코딩 확인 필요")

# 전처리
df["트림"] = df["트림"].fillna("").astype(str).str.strip()
df["세부트림"] = df["세부트림"].fillna("").astype(str).str.strip()
df["브랜드"] = df["브랜드"].astype(str).str.strip()
df["모델명"] = df["모델명"].astype(str).str.strip()
df["연료"] = df["연료"].astype(str).str.upper().str.strip()
df["연식"] = df["연식"].astype(str)

# 광고 문구 생성용 문서
df["광고문구"] = (
        df["브랜드"] + " " +
        df["모델명"] + " " +
        df["트림"] + " " +
        df["세부트림"] + " - " +
        df["연식"] + "년식, " +
        df["연료"] + " 차량"
)

documents = [Document(page_content=row) for row in df["광고문구"].tolist()]
splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=100)
split_docs = splitter.split_documents(documents)

# 임베딩 및 벡터 저장
embeddings = UpstageEmbeddings(model="solar-embedding-1-large", api_key="up_4CGSrG6veWVgB4OItylUF0q3FACj0")

if os.path.exists(CHROMA_DB_DIR):
    vector_db = Chroma(persist_directory=CHROMA_DB_DIR, embedding_function=embeddings)
else:
    vector_db = Chroma.from_documents(split_docs, embedding=embeddings, persist_directory=CHROMA_DB_DIR)
