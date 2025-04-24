import os
from dotenv import load_dotenv

load_dotenv()

#  CSV와 ChromaDB 경로 (기존 설정)
CSV_PATH = "car_magazine_dataset_super_rich_10000.csv"
CHROMA_DB_DIR = "chroma_full_db"

#  Upstage API Key (직접 입력)
UPSTAGE_API_KEY = "up_DWcuunIA5YpcNQOmOXEGwCsq3ws1v"

#  MySQL 설정도 함께 반영하는 경우
MYSQL_HOST = "localhost"
MYSQL_PORT = 3306
MYSQL_USER = "root"
MYSQL_PASSWORD = "1141"
MYSQL_DB = "trustride"
