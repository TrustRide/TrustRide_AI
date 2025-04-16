from fastapi import FastAPI, Form
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from rag_utils import get_rag_response
from router.terms import router as term_router

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

@app.post("/generate_ad", response_class=JSONResponse)
async def generate_ad(
        keyword: str = Form(...),
        category: str = Form(...)
):
    try:
        user_query = f"{keyword} {category}"
        result = get_rag_response(user_query)
        return JSONResponse(content={"ad_text": result}, media_type="application/json; charset=utf-8")
    except Exception as e:
        print("❌ 광고 문구 생성 오류:", e)
        return JSONResponse(content={"ad_text": "🚨 광고 문구 생성 중 오류 발생"}, media_type="application/json; charset=utf-8")
