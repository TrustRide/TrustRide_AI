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
    # ✅ 업로드 디렉토리 생성
    os.makedirs("uploaded", exist_ok=True)
    file_path = os.path.join("uploaded", "temp.pdf")

    # ✅ 파일 저장
    with open(file_path, "wb") as f:
        f.write(file.file.read())

    # ✅ PDF 로딩
    loader = UnstructuredPDFLoader(file_path, mode="elements")
    docs = loader.load()

    # ✅ 문서 청크 분할
    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
    chunks = splitter.split_documents(docs)

    if not chunks:
        return {"summary": "❌ PDF에서 요약할 내용을 추출하지 못했습니다."}

    # ✅ 프롬프트 템플릿 정의
    prompt = PromptTemplate.from_template("""
다음 내용을 3문장 이내로 요약하세요:
{context}
""")

    # ✅ LLM 체인 구성
    chain = RunnableSequence([
        prompt,
        ChatUpstage(model="solar-mini"),
        StrOutputParser()
    ])

    # ✅ 체인 실행
    summary = chain.invoke({"context": chunks[0].page_content})
    return {"summary": summary}
