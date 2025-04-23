from langchain_core.tools import BaseTool, tool
from . import extractor, rag, terms
import logging


logger = logging.getLogger("tools_logger")
logging.basicConfig(level=logging.INFO)

@tool
def PriceTool(message: str) -> str:
    """차량 시세에 대한 질문을 처리합니다. ex: '소나타 시세 알려줘'"""
    parsed = extractor.extract_info_with_llm(message)
    logger.info(f'***** parsed ***** > {parsed}')
    return rag.get_rag_response(parsed)

@tool
def TermsTool(message: str) -> str:
    """약관에 대한 질문을 처리합니다. ex: '가입하려면 어떻게 해?'"""
    context = terms.retriever.invoke(message)
    context_docs = context[0].page_content if context else ""
    logger.info(f'***** context_docs *****\n{context_docs}')
    result = terms.chain.invoke({"question": message, "context": context_docs})
    return result

class StrictMessageTool(BaseTool):
    name: str
    description: str
    tool_func: callable
    original_message: str  # query.message를 여기에 담아둠

    def _run(self, *args, **kwargs) -> str:
        return self.tool_func(self.original_message)

    async def _arun(self, *args, **kwargs) -> str:
        return self.tool_func(self.original_message)
