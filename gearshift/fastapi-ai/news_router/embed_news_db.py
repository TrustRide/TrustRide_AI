# fastapi-ai/news_router/embed_news_db.py
import pymysql
from langchain_community.vectorstores import Chroma
from langchain_core.documents import Document
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_upstage import UpstageEmbeddings
from news_router import settings

def fetch_news_from_mysql():
    conn = pymysql.connect(
        host=settings.MYSQL_HOST,
        user=settings.MYSQL_USER,
        password=settings.MYSQL_PASSWORD,
        db=settings.MYSQL_DB,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    cursor = conn.cursor()
    cursor.execute("SELECT news_id, news_title, news_content FROM news")
    rows = cursor.fetchall()
    conn.close()
    return rows

def build_documents():
    news_list = fetch_news_from_mysql()
    docs = []

    for row in news_list:
        combined = f"{row['news_title']}\n{row['news_content']}"
        doc = Document(
            page_content=combined.strip(),
            metadata={"index": row["news_id"]}
        )
        docs.append(doc)

    print(f"✅ 총 {len(docs)}개 문서를 불러왔습니다.")
    return docs

def embed_and_save():
    docs = build_documents()
    splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=100)
    chunks = splitter.split_documents(docs)

    embedding = UpstageEmbeddings(model="solar-embedding-1-large", api_key=settings.UPSTAGE_API_KEY)
    vectordb = Chroma.from_documents(
        chunks,
        embedding=embedding,
        persist_directory=settings.CHROMA_DB_DIR
    )
    vectordb.persist()
    print("✅ 벡터 저장소 저장 완료")

if __name__ == "__main__":
    embed_and_save()
