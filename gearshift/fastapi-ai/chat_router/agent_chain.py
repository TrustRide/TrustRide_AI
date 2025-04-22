from langchain_upstage import ChatUpstage
from langchain.agents import create_tool_calling_agent, AgentExecutor
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from .tools import PriceTool, TermsTool
from . import settings


llm = ChatUpstage(
    model="solar-1-mini-chat",
    api_key=settings.LLM_API_KEY,
)

tools = [PriceTool, TermsTool]

prompt = ChatPromptTemplate.from_messages([
    (
        "system",
        """
        당신은 사용자 질문에 적절한 도구를 골라서 답변하는 AI입니다.
        절대로 스스로 답변하지 마세요. 반드시 아래 도구 중 하나를 사용하세요:
        
        1. 차량 시세 관련 질문은 PriceTool
        2. 이용약관, 회원가입, 해지, 환불 등의 질문은 TermsTool
        
        도구를 사용하지 않고 답하려고 하면 안 됩니다. 도구가 없으면 '죄송해요, 해당 질문에 대한 답변이 없어요 😢'라고만 하세요. 다른 말은 하지 마세요.
        또한 만약 관련 정보가 없다면 '죄송해요, 해당 질문에 대한 답변이 없어요 😢'라고만 답해주세요. 다른 말은 하지 마세요.
        차량 시세 관련 질문은 답변을 상세하게 해주세요.
        """.strip()
    ),
    MessagesPlaceholder(variable_name="messages"),
    MessagesPlaceholder(variable_name="agent_scratchpad"),
])

agent = create_tool_calling_agent(llm=llm, tools=tools, prompt=prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True, handle_parsing_errors=False)
