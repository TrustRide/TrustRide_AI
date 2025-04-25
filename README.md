# TrustRide AI 프로젝트

TrustRide AI는 차량 관련 인공지능 서비스를 제공하는 웹 애플리케이션입니다. 이 프로젝트는 차량 가격 예측, 손상 감지, 자동차 뉴스 요약 및 추천 기능을 통합하여 사용자에게 보다 정확하고 편리한 차량 정보 서비스를 제공합니다.

## 주요 기능
- **설문조사**: 사용자가 제출한 설문을 바탕으로 중고차 추천합니다.
- **광고**: 사용자가 입력한 키워드와 카테고리 기반으로 광고 문구 생성합니다.
- **잡지**: 최신 자동차 뉴스를 요약하고, 유사한 뉴스를 추천합니다.
- **챗봇**: 챗봇이 이용자의 약관 관련 질문에 응답하며, 중고차 현재 시세와 사용자의 제안 가격을 비교합니다.
- **차량가격예측**: 손상 이미지 분석과 텍스트 기반 피처를 결합하여 실시간 중고차 감가 가격을 예측합니다.

## 기술 스택
- **백엔드**: 
  - Python, FastAPI
  - PyTorch, scikit-learn, LightGBM (AI 모델)
  - ChromaDB, LangChain (RAG 구조)
- **프론트엔드**:
  - React, TypeScript, TailwindCSS
  - Vite 빌드 도구
- **기타**:
  - Spring Legacy + JSP (기존 시스템 연동)
  - MySQL, MyBatis (DB 및 ORM)


## 설치 및 실행 방법

### 1. 프론트엔드 (React)
```bash
cd chatbot-project/chat-design
npm install
npm run dev
```

### 2. 백엔드 (FastAPI)
```bash
cd fastapi-ai
pip install -r requirements.txt
uvicorn app:app --reload
```

### 3. Spring Legacy 서버
- IntelliJ 또는 Eclipse로 프로젝트 열기
- Tomcat 서버 설정 후 실행

## API 문서
FastAPI는 Swagger UI를 통해 API 테스트가 가능합니다.
- 기본 URL: `http://localhost:8000/docs`

## 모델 학습 및 배포
- 손상 감지 모델: PyTorch 기반 ResNet, YOLO, Detectron2 사용
- 가격 예측 모델: LightGBM, RandomForest

