from fastapi import APIRouter
from pydantic import BaseModel
from . import extractor
from . import rag
from . import terms

router = APIRouter(
    prefix="/chat",
    tags=["chat"],
)


### 시세 ###
class UserQuery(BaseModel):
    message: str

class ParsedCarInfo(BaseModel):
    model: str
    fuel_type: str
    offered_price: int

@router.post("/price")
def chat(query: UserQuery):
    parsed = extractor.extract_info_with_llm(query.message)
    answer = rag.get_rag_response(parsed)
    return {
        "parsed_info": parsed,
        "answer": answer
    }


### 약관 ###
class Question(BaseModel):
    query: str

@router.post("/term")
async def ask_question(data: Question):
    query = data.query
    context = terms.retriever.invoke(query)
    context_docs = context[0].page_content if context else ""
    result = terms.chain.invoke({"question": query, "context": context_docs})
    return {"answer": result}
