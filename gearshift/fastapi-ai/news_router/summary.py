from dotenv import load_dotenv
load_dotenv()

from fastapi import APIRouter, UploadFile, File
from pydantic import BaseModel
from langchain_upstage import ChatUpstage
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnableSequence
from langchain_community.document_loaders import UnstructuredPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
import os
from . import settings

router = APIRouter(tags=["summary"])

# ✅ 직접 텍스트 요약
class SummaryRequest(BaseModel):
    content: str

@router.post("/direct-summary")
def direct_summary(req: SummaryRequest):
    prompt = PromptTemplate.from_template("""
당신은 자동차 뉴스 요약 전문가입니다.
다음 내용을 2~3문장으로 요약해 주세요:

{context}
""")
    chain = RunnableSequence(
        prompt,
        ChatUpstage(model="solar-mini", api_key=settings.UPSTAGE_API_KEY),
        StrOutputParser()
    )
    summary = chain.invoke({"context": req.content})
    return {"summary": summary}

# ✅ PDF 요약
@router.post("/pdf-summary")
def summarize_pdf(file: UploadFile = File(...)):
    os.makedirs("uploaded", exist_ok=True)
    file_path = os.path.join("uploaded", "temp.pdf")

    with open(file_path, "wb") as f:
        f.write(file.file.read())

    loader = UnstructuredPDFLoader(file_path, mode="elements")
    docs = loader.load()

    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
    chunks = splitter.split_documents(docs)

    if not chunks:
        return {"summary": "❌ PDF에서 요약할 내용을 추출하지 못했습니다."}

    prompt = PromptTemplate.from_template("""
다음 내용을 3문장 이내로 요약하세요:
{context}
""")

    chain = RunnableSequence(
        prompt,
        ChatUpstage(model="solar-mini", api_key=settings.UPSTAGE_API_KEY),
        StrOutputParser()
    )

    summary = chain.invoke({"context": chunks[0].page_content})
    return {"summary": summary}
