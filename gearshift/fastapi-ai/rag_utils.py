from vector_store import vector_db
from langchain.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_upstage import ChatUpstage

# LLM 및 파서 초기화
llm = ChatUpstage(model="solar-1-mini-chat", api_key="up_4CGSrG6veWVgB4OItylUF0q3FACj0")
output_parser = StrOutputParser()

prompt_template = PromptTemplate.from_template("""
당신은 자동차 광고 전문 마케터입니다.
다음은 유사한 차량 정보입니다:

{context}

이 정보를 참고하여, 사용자의 요청 "{query}"에 맞는
매력적이고 세련된 중고차 광고 문구를 10문장 정도로 작성해주세요.

[요구 조건]
- 자연스럽고 감성적인 톤
- 강조 포인트가 명확할 것
- 존댓말 사용
""")

# RAG 응답 생성 함수
def get_rag_response(query: str) -> str:
    try:
        docs = vector_db.similarity_search(query, k=3)
        context = "\n".join([doc.page_content for doc in docs])
        prompt = prompt_template.format_prompt(context=context, query=query).to_string()

        print("🧪 생성된 프롬프트:\n", prompt)

        response = llm.invoke(prompt)
        print("📤 LLM 응답:", response)

        return output_parser.invoke(response).strip()

    except Exception as e:
        print(f"❌ RAG 오류 (query: {query}):", e)
        return "🚨 광고 문구 생성 중 오류 발생"
