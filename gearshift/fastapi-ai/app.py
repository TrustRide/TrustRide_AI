from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from chat_router.chat import router as chat_router
from recommend_router.recommend import router as recommend_router
from ad_router.ad import router as ad_router
from news_router.summary import router as news_router
from news_router.similarity import router as similarity_router


app = FastAPI()

# CORS 설정 (Spring JSP 등 외부에서 접근 허용)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080", "http://127.0.0.1:8080"],  # JSP 서버
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 모든 기능 라우터 등록
app.include_router(chat_router)
app.include_router(recommend_router)
app.include_router(ad_router)
app.include_router(news_router)  #  요약 라우터 추가
app.include_router(similarity_router)
