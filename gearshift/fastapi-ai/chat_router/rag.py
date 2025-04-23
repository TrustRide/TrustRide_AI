import pandas as pd
from langchain_upstage import ChatUpstage
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from . import settings

# LLM 초기화
llm = ChatUpstage(api_key=settings.LLM_API_KEY, model="solar-1-mini-chat")
output_parser = StrOutputParser()

# 자연어 응답 템플릿
response_prompt = PromptTemplate.from_template("""
당신은 중고차 시세 전문가입니다.

{filtered_info} 차량을 {offered_price}만원에 구매하려고 합니다.
이 차량의 평균 시세는 {avg_price}만원입니다.
{verdict}
위 정보를 바탕으로 사용자에게 친절하게 설명해주세요.
중복되거나 뻔한 표현은 피하고, 핵심 정보만 간결하게 전달하세요.
또한 "신중히 결정하세요", "전문가에게 물어보세요", "문의해 주세요" 같은 말은 하지 마세요.
""")

def get_rag_response(info):
    # 1. 데이터 로드 및 정리
    df = pd.read_csv(settings.CSV_PATH)
    df = df.rename(columns={'모델명': 'model', '연료': 'fuel_type', '트림': 'trim', '가격': 'price'})

    # 🔥 공백 제거 필수! (이 줄 추가)
    df['model'] = df['model'].astype(str).str.strip()
    df['fuel_type'] = df['fuel_type'].astype(str).str.strip()
    df['trim'] = df['trim'].astype(str).str.strip()

    # 2. 입력 정보 정리
    model = info.get('model', '').strip()
    fuel = info.get('fuel_type', '').strip()
    trim = info.get('trim', '').strip() if 'trim' in info else ''
    offer = float(info.get('offered_price'))

    # 3. 조건별 필터링
    filtered = pd.DataFrame()

    # 우선순위 1: 모델 + 연료 + 트림
    if model and fuel and trim:
        filtered = df[
            (df['model'] == model) &
            (df['fuel_type'] == fuel) &
            (df['trim'] == trim)
            ]

    # 우선순위 2: 모델 + 트림
    if filtered.empty and model and trim:
        filtered = df[
            (df['model'] == model) &
            (df['trim'] == trim)
            ]

    # 4. 결과 없으면 사과 메시지
    if filtered.empty:
        return "죄송하지만 제공된 정보로는 정확한 판단이 어렵습니다."

    # 5. 평균 시세 계산
    avg_price = filtered['price'].astype(float).mean()

    # 6. 가격 비교 판단
    if offer < avg_price:
        verdict = "제시한 가격이 시세보다 저렴합니다. 좋은 조건이에요!"
    elif offer > avg_price:
        verdict = "제시한 가격이 시세보다 비쌉니다. 신중히 고려해보세요."
    else:
        verdict = "제시한 가격은 시세와 거의 같습니다."

    # 7. 차량 정보 조합
    filtered_info = f"{model}"
    if fuel:
        filtered_info += f" ({fuel})"
    if trim:
        filtered_info += f" [{trim}]"

    # 8. 프롬프트에 적용 후 LLM 응답
    prompt = response_prompt.format(
        filtered_info=filtered_info,
        offered_price=offer,
        avg_price=int(avg_price),
        verdict=verdict
    )

    return (llm | output_parser).invoke(prompt)
