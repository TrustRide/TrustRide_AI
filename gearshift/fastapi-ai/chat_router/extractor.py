from langchain_upstage import ChatUpstage
from langchain_core.prompts import PromptTemplate
import json
from . import settings

# Upstage LLM 인스턴스 생성
llm = ChatUpstage(api_key=settings.LLM_API_KEY, model="solar-1-mini-chat")


# 차량 정보 추출을 위한 프롬프트 템플릿 정의
extract_prompt = PromptTemplate.from_template("""
다음 문장에서 차량의 모델명, 연료, 트림, 제시 가격(만원)을 추출해 아래 JSON 형식으로 정확히 반환해줘.
형식: {{ "model": "모델명", "fuel_type": "연료", "trim": "트림", "offered_price": 0000 }}

예시:
문장: "쏘나타 뉴 라이즈 가솔린 2.0 스마트를 1,800만원에 사려는데 괜찮아?"
결과: {{ "model": "쏘나타 뉴 라이즈", "fuel_type": "가솔린", "trim": "2.0 스마트", "offered_price": 1800 }}

문장: "{message}"
""")

# LLM 응답을 수동으로 JSON으로 파싱하는 클래스 정의
class ManualJsonParser:
    def invoke(self, text: str):
        try:
             # 문자열을 JSON으로 변환 시도
            return json.loads(text)
        except Exception:
            # 실패하면 에러 메시지와 함께 예외 발생
            raise ValueError("🚫 JSON 파싱 실패: 응답 형식이 잘못되었을 수 있습니다.\n내용:\n" + text)

# 파서 인스턴스 생성
parser = ManualJsonParser()

# 사용자의 자연어 메시지를 받아서 차량 정보를 추출하는 함수
def extract_info_with_llm(message: str):

    # 입력 메시지를 프롬프트에 삽입
    prompt = extract_prompt.format(message=message)

    # LLM에게 프롬프트 전달하여 응답 받기
    raw_output = llm.invoke(prompt)

     # LLM 응답에서 content만 추출하여 JSON으로 파싱 
    return parser.invoke(raw_output.content)  
