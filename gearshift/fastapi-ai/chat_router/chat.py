from fastapi import APIRouter
from typing import Optional
from pydantic import BaseModel
from . import extractor, rag, terms
from langchain_core.messages import HumanMessage
from .agent_chain import agent_executor
import logging

logger = logging.getLogger("chat_logger")
logging.basicConfig(level=logging.INFO)

router = APIRouter(
    prefix="/chat",
    tags=["chat"],
)

class UserQuery(BaseModel):
    message: str


### 시세 ###
class ParsedCarInfo(BaseModel):
    model: str
    fuel_type: Optional[str] = ""
    offered_price: str
    trim: Optional[str] = ""           

@router.post("/price")
def chat(query: UserQuery):
    parsed = extractor.extract_info_with_llm(query.message)
    answer = rag.get_rag_response(parsed)
    return {
        "parsed_info": parsed,
        "answer": answer
    }


### 약관 ###
@router.post("/term")
async def ask_question(query: UserQuery):
    query = query.message
    context = terms.retriever.invoke(query)
    context_docs = context[0].page_content if context else ""
    result = terms.chain.invoke({"question": query, "context": context_docs})
    return {"answer": result}


### 통합 ###
@router.post("/integrate")
async def integrated_chat(query: UserQuery):
    result = await agent_executor.ainvoke({"messages": [HumanMessage(content=query.message)]})

    # LLM이 tool을 쓰지 않고 LLM의 생각으로 답변했는지 체크
    if isinstance(result, str):
        logger.error('LLM이 도구를 사용하지 않고 마음대로 답변')
        return {"answer": "죄송해요, 해당 질문에 대한 답변이 없어요 😢"}

    # tool 실행 결과만 꺼내기
    tool_outputs = result.get("intermediate_steps", []) #실행 결과가 없으면 [] 빈 리스트를 응답

    for step in tool_outputs:
        if isinstance(step, tuple):
            _, tool_output = step
            return {"answer": tool_output}

    # tool 실행 결과가 빈 리스트라면
    return {"answer": "죄송해요, 해당 질문에 대한 답변이 없어요 😢"}