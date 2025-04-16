import pandas as pd
from langchain_community.vectorstores import Chroma
from langchain_upstage import UpstageEmbeddings
from langchain_core.documents import Document
from langchain_text_splitters import RecursiveCharacterTextSplitter
import os

CHROMA_DB_DIR = "./chroma_db"
DATA_PATH = "car_data.csv"

# CSV 로드 및 전처리
encoding_list = ["utf-8", "cp949", "euc-kr"]
df = None
for enc in encoding_list:
    try:
        df = pd.read_csv(DATA_PATH, encoding=enc)
        break
    except Exception:
        continue
if df is None:
    raise ValueError("❌ CSV 파일 로딩 실패: 인코딩 확인 필요")

df["트림"] = df["트림"].fillna("").astype(str).str.strip()
df["세부트림"] = df["세부트림"].fillna("").astype(str).str.strip()
df["브랜드"] = df["브랜드"].astype(str).str.strip()
df["모델명"] = df["모델명"].astype(str).str.strip()
df["연료"] = df["연료"].astype(str).str.upper().str.strip()
df["연식"] = df["연식"].astype(str)

# 광고 문구 생성용 문서 생성
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

embeddings = UpstageEmbeddings(model="solar-embedding-1-large", api_key="up_Cyk5oYYEV4A6OW26vjPld4WikIfXU")
if os.path.exists(CHROMA_DB_DIR):
    vector_db = Chroma(persist_directory=CHROMA_DB_DIR, embedding_function=embeddings)
else:
    vector_db = Chroma.from_documents(split_docs, embedding=embeddings, persist_directory=CHROMA_DB_DIR)