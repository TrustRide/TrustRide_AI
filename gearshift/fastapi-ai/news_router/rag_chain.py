import pandas as pd
from langchain_community.vectorstores import Chroma
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_core.documents import Document
from langchain_upstage import UpstageEmbeddings, ChatUpstage
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from settings import CSV_PATH, CHROMA_DB_DIR


#  CSV → LangChain 문서 객체로 변환
def load_documents_from_csv():
    df = pd.read_csv(CSV_PATH)

    if "title" not in df.columns or "content" not in df.columns:
        raise ValueError(" 'title' 또는 'content' 컬럼이 없습니다.")

    docs = []
    for i, row in df.iterrows():
        title = str(row["title"]).strip()
        content = str(row["content"]).strip()
        combined = f"{title}\n{content}"

        if combined:
            docs.append(Document(page_content=combined, metadata={"index": i}))

    print(f" 문서 로드 완료: {len(docs)}개")
    return docs


#  벡터 저장소 생성 (Chroma)
def create_vectorstore():
    docs = load_documents_from_csv()

    splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=100)
    split_docs = splitter.split_documents(docs)

    print(f" 청크 분할 완료: {len(split_docs)}개")

    embedding = UpstageEmbeddings(model="solar-embedding-1-large")
    vectordb = Chroma.from_documents(
        split_docs,
        embedding=embedding,
        persist_directory=CHROMA_DB_DIR
    )
    vectordb.persist()
    print(" ChromaDB 벡터 저장 완료")


#  저장된 벡터 저장소 로드
def load_vectorstore():
    embedding = UpstageEmbeddings(model="solar-embedding-1-large")
    db = Chroma(persist_directory=CHROMA_DB_DIR, embedding_function=embedding)
    print(" 저장된 벡터 개수:", db._collection.count())
    return db


#  context가 없을 경우 기본 문구 반환 + 디버깅 로그 추가
def safe_context_retriever(retriever):
    def _retrieve(input_dict):
        question = input_dict["question"]
        docs = retriever.get_relevant_documents(question)
        print(f" 검색된 문서 수: {len(docs)}")

        if not docs:
            print(" 관련 문서 없음 → 기본 문맥 사용")
            return "관련 문서를 찾을 수 없습니다."

        result = "\n\n".join([doc.page_content for doc in docs])
        print(f" 최종 context 길이: {len(result)}")
        return result

    return _retrieve


#  RAG 체인 생성
def create_rag_chain():
    retriever = load_vectorstore().as_retriever()
    llm = ChatUpstage(model="solar-mini")

    prompt = PromptTemplate.from_template("""
당신은 차량 뉴스 요약 전문가입니다.
다음 문맥을 참고해 질문에 정확하게 요약 응답을 해주세요.

문맥 정보:
{context}

질문:
{question}
""")

    return (
        {
            "context": safe_context_retriever(retriever),
            "question": lambda x: x["question"]
        }
        | prompt
        | llm
        | StrOutputParser()
    )


#  실행 시: 벡터 저장만
if __name__ == "__rang__":
    create_vectorstore()
    print(" 전체 완료: ChromaDB 초기화 성공")
