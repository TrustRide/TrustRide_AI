
from .rag_utils import get_rag_response   # ⬅️ 같은 패키지 안 → 상대 import

from fastapi import APIRouter, Form
from fastapi.responses import JSONResponse


router = APIRouter(tags=["ad"])


@router.post("/generate_ad", response_class=JSONResponse)
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
