from fastapi import HTTPException, APIRouter
from pydantic import BaseModel
from . import extractor
from . import rag

from dotenv import load_dotenv
load_dotenv()

router = APIRouter(
    prefix="/price",
    tags=["price"],
)

class UserQuery(BaseModel):
    message: str

class ParsedCarInfo(BaseModel):
    model: str
    fuel_type: str
    offered_price: int


@router.post("/chat")
def chat(query: UserQuery):
    parsed = extractor.extract_info_with_llm(query.message)
    answer = rag.get_rag_response(parsed)
    return {
        "parsed_info": parsed,
        "answer": answer
    }
