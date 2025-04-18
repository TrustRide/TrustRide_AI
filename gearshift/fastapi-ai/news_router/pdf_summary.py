from fastapi import FastAPI, UploadFile, File
from langchain_community.document_loaders import UnstructuredPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_core.prompts import PromptTemplate
from langchain_upstage import ChatUpstage
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnableSequence
import os

app = FastAPI()

@app.post("/pdf-summary")
def summarize_pdf(file: UploadFile = File(...)):
    # 파일 저장
    os.makedirs("uploaded", exist_ok=True)
    with open("uploaded/temp.pdf", "wb") as f:
        f.write(file.file.read())

    # PDF 로드
    loader = UnstructuredPDFLoader("uploaded/temp.pdf", mode="elements")
    docs = loader.load()

    # 청크 분할
    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
    chunks = splitter.split_documents(docs)

    if not chunks:
        return {"summary": "PDF에서 텍스트를 추출할 수 없습니다."}

    # 프롬프트 및 체인 구성
    prompt = PromptTemplate.from_template("""
다음 내용을 3문장 이내로 요약하세요.
{context}
""")

    # ✅ 오류 방지: RunnableSequence로 체인 구성
    chain = RunnableSequence(steps=[
        prompt,
        ChatUpstage(model="solar-mini"),
        StrOutputParser()
    ])

    # 요약 실행
    summary = chain.invoke({"context": chunks[0].page_content})
    return {"summary": summary}
