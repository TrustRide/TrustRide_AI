from langchain_community.vectorstores import Chroma
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_core.documents import Document
from langchain_upstage import ChatUpstage, UpstageEmbeddings
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
import pandas as pd
import os
from . import settings

# 프롬프트 템플릿
prompt_template = PromptTemplate.from_template("""
당신은 중고차 시세 전문가입니다.
사용자 질문: {question}

관련 차량 시세:
{context}

위 정보를 참고하여 현재 사용자가 제시한 가격이 시세보다 싼지 비싼지 자연어로 간결하게 설명해 주세요.
""")

# Upstage LLM 및 임베딩 모델 초기화
llm = ChatUpstage(api_key=settings.LLM_API_KEY, model="solar-1-mini-chat")
output_parser = StrOutputParser()
embeddings = UpstageEmbeddings(model="solar-embedding-1-large", api_key=settings.LLM_API_KEY)

# 벡터 DB 초기화
if os.path.exists(settings.CHROMA_DB_DIR):
    # 기존 백터 DB가 있다면 로드
    vector_store = Chroma(persist_directory=settings.CHROMA_DB_DIR, embedding_function=embeddings)
else:
    # 기존 백터 DB가 없다면 새로 생성
    df = pd.read_csv(settings.CSV_PATH)
    # 컬럼명 통일 ( 예 : 한글 -> 영어)
    df = df.rename(columns={'모델명': 'model', '연료': 'fuel_type', '트림': 'trim', '가격': 'price'})
    
    # 각 행을 문서로 변환 
    texts = [
        Document(page_content=f"모델: {row['model']}, 연료: {row['fuel_type']}, 트림: {row['trim']}, 가격: {row['price']}만원")
        for _, row in df.iterrows()
    ]

     # 문서를 일정 길이로 분할
    splitter = RecursiveCharacterTextSplitter(chunk_size=200, chunk_overlap=20)
    docs = splitter.split_documents(texts)

    # 백터 DB에 저장
    vector_store = Chroma.from_documents(docs, embeddings, persist_directory=settings.CHROMA_DB_DIR)

# === RAG 응답 생성 함수 ===
def get_rag_response(info):

    # 사용자가 입력한 정보 기반으로 쿼리 생성
    query = f"{info['model']} {info['fuel_type']} 중고차 시세"
    
    # 유사한 문서 5개 검색
    docs = vector_store.similarity_search(query, k=5)

    # 문서 없음 + context가 너무 짧거나 공백뿐인 경우 처리
    context = "\n".join([doc.page_content for doc in docs]).strip()

    # 검색된 문서들을 문맥으로 구성
    context = "\n".join([doc.page_content for doc in docs])

    # 사용자 질문 구성 
    question = f"{info['model']} {info['fuel_type']} 차량을 {info['offered_price']}만원에 구매하려고 합니다. 괜찮은 가격인가요?"
    
    # 최종 프롬프트 구성
    prompt = prompt_template.format(question=question, context=context)

    # LLM 호출 및 결과 리턴 
    result = llm | output_parser
    return result.invoke(prompt)

