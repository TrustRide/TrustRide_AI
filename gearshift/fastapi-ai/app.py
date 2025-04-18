from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from chat_router.chat import router as chat_router
from recommend_router.recommend import router as recommend_router
from ad_router.ad import router as ad_router



app = FastAPI()

# CORS 허용
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080", "http://127.0.0.1:8080"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(chat_router)
app.include_router(recommend_router)
app.include_router(ad_router)


