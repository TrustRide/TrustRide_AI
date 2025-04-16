from fastapi import APIRouter
from pydantic import BaseModel
from langchain_upstage import ChatUpstage, UpstageEmbeddings
from langchain_chroma import Chroma
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_community.document_loaders import TextLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter

from dotenv import load_dotenv
load_dotenv()

router = APIRouter(
    prefix="/terms",
    tags=["term"],
)

class Question(BaseModel):
    query: str


# 초기 세팅 (한번만 로딩)
loader = TextLoader("./router/Trust_Ride_Terms.txt", encoding="utf-8")
docs = loader.load()

splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
splits = splitter.split_documents(docs)

embeddings = UpstageEmbeddings(model="solar-embedding-1-large")
vector_store = Chroma(embedding_function=embeddings)
vector_store.add_documents(splits)
retriever = vector_store.as_retriever() #벡터 db에서 문장좀 찾아줘..

llm = ChatUpstage(model="solar-pro")
prompt_template = PromptTemplate.from_template(
    '''
    아래의 컨텍스트에서 가장 적합한 답변을 작성해주세요.
    만약 관련 정보가 없다면 '죄송해요, 해당 질문에 대한 답변이 없어요 😢'라고 답해주세요.
    ---
    질문: {question}
    ---
    컨텍스트: {context}
    '''
)
chain = prompt_template | llm | StrOutputParser()


@router.post("/ask")
async def ask_question(data: Question):
    query = data.query
    context = retriever.invoke(query)
    context_docs = context[0].page_content if context else ""
    result = chain.invoke({"question": query, "context": context_docs})
    return {"answer": result}