from fastapi import FastAPI, Form
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from router.terms import router as term_router
from router.market_price import router as price_router
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

app.include_router(term_router)
app.include_router(price_router)
app.include_router(recommend_router)
app.include_router(ad_router)


