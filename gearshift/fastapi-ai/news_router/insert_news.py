from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from langchain_upstage import UpstageEmbeddings
from langchain_community.vectorstores import Chroma
from langchain_core.documents import Document
from . import settings  # settings.py에 CHROMA_DB_DIR, UPSTAGE_API_KEY 설정 필요

router = APIRouter(tags=["vector-db"])

# DB 컬럼명 기준으로 필드명 정의
class NewsInsertRequest(BaseModel):
    news_id: int
    news_title: str
    news_content: str


#  임베딩 모델 및 Chroma 초기화
embedding_model = UpstageEmbeddings(
    model="solar-embedding-1-large",
    api_key=settings.UPSTAGE_API_KEY
)


vector_store = Chroma(
    persist_directory=settings.CHROMA_DB_DIR,
    embedding_function=embedding_model
)


#  벡터 DB에 뉴스 삽입 API
@router.post("/insert-news")
def insert_news(req: NewsInsertRequest):
    try:
        full_text = req.news_title.strip() + "\n" + req.news_content.strip()
        doc = Document(page_content=full_text, metadata={"news_id": req.news_id})
        vector_store.add_documents([doc])
        return {"message": "뉴스가 벡터 DB에 성공적으로 추가되었습니다."}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))



