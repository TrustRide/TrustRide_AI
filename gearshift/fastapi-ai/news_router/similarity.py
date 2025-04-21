from fastapi import APIRouter
from pydantic import BaseModel
import pymysql
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity
from langchain_upstage import UpstageEmbeddings, ChatUpstage
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from . import settings  # settings.py 로드

router = APIRouter(tags=["similarity"])

#  요청 바디 모델
class SimilarityRequest(BaseModel):
    content: str

#  요약 체인 설정
summary_prompt = PromptTemplate.from_template("""
당신은 자동차 뉴스 요약 전문가입니다.
다음 내용을 2~3문장으로 요약해 주세요:

{context}
""")

summary_chain = (
        summary_prompt
        | ChatUpstage(model="solar-mini", api_key=settings.UPSTAGE_API_KEY)
        | StrOutputParser()
)

#  임베딩 모델 초기화
embedding_model = UpstageEmbeddings(model="solar-embedding-1-large", api_key=settings.UPSTAGE_API_KEY)

#  유사 뉴스 검색 API
@router.post("/news-similarity")
def find_similar_news(req: SimilarityRequest):
    user_content = req.content.strip()

    # 1. 요약 수행
    summary = summary_chain.invoke({"context": user_content})

    # 2. 사용자 입력 임베딩
    user_embedding = embedding_model.embed_query(user_content)

    # 3. MySQL에서 전체 뉴스 로딩
    connection = pymysql.connect(
        host=settings.MYSQL_HOST,
        user=settings.MYSQL_USER,
        password=settings.MYSQL_PASSWORD,
        db=settings.MYSQL_DB,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

    with connection.cursor() as cursor:
        cursor.execute("SELECT news_id, news_title, news_content FROM news")
        rows = cursor.fetchall()

    if not rows:
        return {"summary": summary, "related_news": []}

    # 4. 뉴스 임베딩
    corpus_texts = [row['news_title'] + "\n" + row['news_content'] for row in rows]
    corpus_embeddings = embedding_model.embed_documents(corpus_texts)

    # 5. 유사도 계산
    similarities = cosine_similarity([user_embedding], corpus_embeddings)[0]
    top_indices = np.argsort(similarities)[::-1][:4]

    # 6. 결과 구성
    related_news = []
    for idx in top_indices:
        row = rows[idx]
        related_news.append({
            "title": row['news_title'],
            "link": f"/newsDetail?newsId={row['news_id']}"
        })

    return {
        "summary": summary,
        "related_news": related_news
    }
