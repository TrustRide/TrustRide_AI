# predct_router.py 이미지 기반 손상 감지

from fastapi import APIRouter, UploadFile, File, Form
from fastapi.responses import JSONResponse
import torch
from PIL import Image
import os
import io
from torchvision import transforms
from torchvision.models import resnet18, ResNet18_Weights
import joblib
import lightgbm as lgb
import numpy as np
from scipy.sparse import hstack, csr_matrix
import traceback

router = APIRouter(prefix="/carpredict", tags=["손상 및 가격 예측"])

#  절대 경로 설정
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MODEL_DIR = os.path.join(BASE_DIR, "predict_router", "models")
UPLOAD_DIR = os.path.join(BASE_DIR, "uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)

#  경로 디버깅용 출력 (필요시 주석 제거)
# print(f"MODEL_DIR: {MODEL_DIR}")
# print(f"UPLOAD_DIR: {UPLOAD_DIR}")

#  모델 파일 경로
DAMAGE_MODEL_PATH = os.path.join(MODEL_DIR, "damage_model.pth")
PRICE_MODEL_PATH = os.path.join(MODEL_DIR, "lgbm_price_model.txt")
SCALER_PATH = os.path.join(MODEL_DIR, "scaler.pkl")
VECTORIZER_PATH = os.path.join(MODEL_DIR, "vectorizer.pkl")
BRAND_ENCODER_PATH = os.path.join(MODEL_DIR, "brand_encoder.pkl")
FUEL_ENCODER_PATH = os.path.join(MODEL_DIR, "fuel_encoder.pkl")
VEHICLE_TYPE_ENCODER_PATH = os.path.join(MODEL_DIR, "vehicle_type_encoder.pkl")
TRIM_ENCODER_PATH = os.path.join(MODEL_DIR, "trim_encoder.pkl")

#  손상 모델 로드
try:
    device = torch.device("cpu")
    model = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)
    model.fc = torch.nn.Linear(model.fc.in_features, 2)
    model.load_state_dict(torch.load(DAMAGE_MODEL_PATH, map_location="cpu"))
    model.eval()
except Exception as e:
    print(f"Error loading damage model: {str(e)}")
    raise

#  가격 예측 모델 로드
try:
    price_model = lgb.Booster(model_file=PRICE_MODEL_PATH)
    scaler = joblib.load(SCALER_PATH)
    vectorizer = joblib.load(VECTORIZER_PATH)
    brand_encoder = joblib.load(BRAND_ENCODER_PATH)
    fuel_encoder = joblib.load(FUEL_ENCODER_PATH)
    vehicle_type_encoder = joblib.load(VEHICLE_TYPE_ENCODER_PATH)
    trim_encoder = joblib.load(TRIM_ENCODER_PATH)
except Exception as e:
    print(f"Error loading price prediction models: {str(e)}")
    raise

#  이미지 전처리
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
])

@router.post("")
async def predict_combined(
        file: UploadFile = File(...),
        model_name: str = Form(...),
        trim_summary: str = Form(...),
        brand: str = Form(...),
        fuel_type: str = Form(...),
        vehicle_type: str = Form(...),
        year: int = Form(...),
        km_driven: int = Form(...)
):
    try:
        #  이미지 저장 및 예측
        contents = await file.read()
        filename = file.filename
        image_path = os.path.join(UPLOAD_DIR, filename)
        with open(image_path, "wb") as f:
            f.write(contents)
        image = Image.open(io.BytesIO(contents)).convert("RGB")
        image_tensor = transform(image).unsqueeze(0)
        with torch.no_grad():
            output = model(image_tensor)
            probs = torch.softmax(output, dim=1)
            confidence = probs[0][1].item()
            pred_class = torch.argmax(probs, 1).item()

        #  손상 판단
        if pred_class == 0:
            damage_level = "손상 없음"
            price_loss = 0
            price_loss_ratio = 0
            reason = "손상이 없으므로 감가 없이 최종 가격이 유지됩니다."
        else:
            if confidence > 0.9:
                damage_level = "⚠️ 심한 손상"
                price_loss_ratio = 0.2
                reason = "손상 정도가 심하므로 예측가의 20% 이상이 감가되었습니다."
            elif confidence > 0.6:
                damage_level = "⚠️ 경미한 손상"
                price_loss_ratio = 0.1
                reason = "손상 정도가 경미하여 예측가의 5~10%가 감가되었습니다."
            else:
                damage_level = "⚠️ 경미하거나 불확실한 손상"
                price_loss_ratio = 0.05
                reason = "손상 판단이 불확실하여 소폭 감가되었습니다."

        #  모델 요약 생성
        model_summary = f"{model_name} {trim_summary}"

        #  텍스트 벡터화 (TF-IDF)
        X_text = vectorizer.transform([model_summary])

        #  라벨 인코딩
        brand_encoded = brand_encoder.transform([brand])[0]
        fuel_encoded = fuel_encoder.transform([fuel_type])[0]
        vehicle_type_encoded = vehicle_type_encoder.transform([vehicle_type])[0]
        trim_encoded = trim_encoder.transform([trim_summary])[0]

        #  수치형 데이터 정규화
        X_num = np.array([[year, km_driven]])
        X_num_scaled = scaler.transform(X_num)
        year_scaled, km_driven_scaled = X_num_scaled[0]

        #  모든 특성 결합
        X_other = np.array([[brand_encoded, fuel_encoded, vehicle_type_encoded, trim_encoded, year_scaled, km_driven_scaled]])
        X_other_sparse = csr_matrix(X_other)
        X_all = hstack([X_text, X_other_sparse])

        #  예측
        predicted_price = int(price_model.predict(X_all)[0])

        #  감가 적용
        price_loss = int(predicted_price * price_loss_ratio) if pred_class == 1 else 0
        final_price = predicted_price - price_loss

        return JSONResponse(
            content={
                "filename": filename,
                "predicted_price": predicted_price,
                "damage_level": damage_level,
                "price_loss": price_loss,
                "final_price": final_price,
                "deduction_reason": reason,
                "model_summary": model_summary
            },
            media_type="application/json; charset=utf-8"
        )

    except Exception as e:
        traceback.print_exc()
        return JSONResponse(
            status_code=500,
            content={"error": str(e)},
            media_type="application/json; charset=utf-8"
        )

@router.get("/health")
async def health_check():
    try:
        _ = price_model
        _ = model
        return {"status": "healthy", "message": "모델 정상 작동 중"}
    except Exception as e:
        return {"status": "error", "detail": str(e)}


# from fastapi import APIRouter, UploadFile, File, Form
# from fastapi.responses import JSONResponse
# import torch
# from PIL import Image
# import os
# import io
# from torchvision import transforms
# from torchvision.models import resnet18, ResNet18_Weights
# import joblib
# import lightgbm as lgb
# import numpy as np
# from scipy.sparse import hstack, csr_matrix
# import traceback
#
# router = APIRouter(prefix="/carpredict", tags=["손상 및 가격 예측"])
#
#
#
# #  모델 파일 경로 설정
# BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# MODEL_DIR = os.path.join(BASE_DIR, "models")
# DAMAGE_MODEL_PATH = os.path.join(MODEL_DIR, "damage_model.pth")
# PRICE_MODEL_PATH = os.path.join(MODEL_DIR, "lgbm_price_model.txt")  # .pkl → .txt
# SCALER_PATH = os.path.join(MODEL_DIR, "scaler.pkl")
# VECTORIZER_PATH = os.path.join(MODEL_DIR, "vectorizer.pkl")
# BRAND_ENCODER_PATH = os.path.join(MODEL_DIR, "brand_encoder.pkl")
# FUEL_ENCODER_PATH = os.path.join(MODEL_DIR, "fuel_encoder.pkl")
# VEHICLE_TYPE_ENCODER_PATH = os.path.join(MODEL_DIR, "vehicle_type_encoder.pkl")
# TRIM_ENCODER_PATH = os.path.join(MODEL_DIR, "trim_encoder.pkl")
#
# #  업로드 디렉토리 설정
# UPLOAD_DIR = "C:/upload"
# os.makedirs(UPLOAD_DIR, exist_ok=True)  # 디렉토리 없으면 생성
#
# #  손상 모델
# try:
#     device = torch.device("cpu")
#     model = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)  # 경고 제거
#     model.fc = torch.nn.Linear(model.fc.in_features, 2)
#     model.load_state_dict(torch.load(DAMAGE_MODEL_PATH, map_location="cpu"))
#     model.eval()
# except Exception as e:
#     print(f"Error loading damage model: {str(e)}")
#     raise
#
# #  가격 예측 관련 파일
# try:
#     price_model = lgb.Booster(model_file=PRICE_MODEL_PATH)  # joblib → lightgbm
#     scaler = joblib.load(SCALER_PATH)
#     vectorizer = joblib.load(VECTORIZER_PATH)
#     brand_encoder = joblib.load(BRAND_ENCODER_PATH)
#     fuel_encoder = joblib.load(FUEL_ENCODER_PATH)
#     vehicle_type_encoder = joblib.load(VEHICLE_TYPE_ENCODER_PATH)
#     trim_encoder = joblib.load(TRIM_ENCODER_PATH)
# except Exception as e:
#     print(f"Error loading price prediction models: {str(e)}")
#     raise
#
# #  이미지 전처리
# transform = transforms.Compose([
#     transforms.Resize((224, 224)),
#     transforms.ToTensor(),
# ])
#
# @router.post("")
# async def predict_combined(
#     file: UploadFile = File(...),
#     model_name: str = Form(...),
#     trim_summary: str = Form(...),
#     brand: str = Form(...),
#     fuel_type: str = Form(...),
#     vehicle_type: str = Form(...),
#     year: int = Form(...),
#     km_driven: int = Form(...)
# ):
#     try:
#         #  이미지 저장 및 예측
#         contents = await file.read()
#         filename = file.filename
#         image_path = os.path.join(UPLOAD_DIR, filename)
#         with open(image_path, "wb") as f:
#             f.write(contents)
#         image = Image.open(io.BytesIO(contents)).convert("RGB")
#         image_tensor = transform(image).unsqueeze(0)
#         with torch.no_grad():
#             output = model(image_tensor)
#             probs = torch.softmax(output, dim=1)
#             confidence = probs[0][1].item()
#             pred_class = torch.argmax(probs, 1).item()
#
#         #  손상 판단
#         if pred_class == 0:
#             damage_level = "손상 없음"
#             price_loss = 0
#             price_loss_ratio = 0  # 명시적 초기화
#             reason = "손상이 없으므로 감가 없이 최종 가격이 유지됩니다."
#         else:
#             if confidence > 0.9:
#                 damage_level = "⚠️ 심한 손상"
#                 price_loss_ratio = 0.2
#                 reason = "손상 정도가 심하므로 예측가의 20% 이상이 감가되었습니다."
#             elif confidence > 0.6:
#                 damage_level = "⚠️ 경미한 손상"
#                 price_loss_ratio = 0.1
#                 reason = "손상 정도가 경미하여 예측가의 5~10%가 감가되었습니다."
#             else:
#                 damage_level = "⚠️ 경미하거나 불확실한 손상"
#                 price_loss_ratio = 0.05
#                 reason = "손상 판단이 불확실하여 소폭 감가되었습니다."
#
#         #  모델 요약 생성
#         model_summary = f"{model_name} {trim_summary}"
#
#         #  텍스트 벡터화 (TF-IDF)
#         X_text = vectorizer.transform([model_summary])
#
#         #  라벨 인코딩
#         brand_encoded = brand_encoder.transform([brand])[0]
#         fuel_encoded = fuel_encoder.transform([fuel_type])[0]
#         vehicle_type_encoded = vehicle_type_encoder.transform([vehicle_type])[0]
#         trim_encoded = trim_encoder.transform([trim_summary])[0]
#
#         #  수치형 데이터 정규화 (다변량 스케일러 적용)
#         X_num = np.array([[year, km_driven]])
#         X_num_scaled = scaler.transform(X_num)
#         year_scaled = X_num_scaled[0][0]
#         km_driven_scaled = X_num_scaled[0][1]
#
#         #  모든 특성 결합 (희소 행렬 변환)
#         X_other = np.array([[brand_encoded, fuel_encoded, vehicle_type_encoded, trim_encoded, year_scaled, km_driven_scaled]])
#         X_other_sparse = csr_matrix(X_other)
#         X_all = hstack([X_text, X_other_sparse])
#
#         #  예측
#         predicted_price = int(price_model.predict(X_all)[0])
#
#         #  최종 감가 적용
#         price_loss = int(predicted_price * price_loss_ratio) if pred_class == 1 else 0
#         final_price = predicted_price - price_loss
#
#
#
#         return JSONResponse(
#             content={
#                 "filename": filename,   # 이미지 파일명
#                 "predicted_price": predicted_price, # 예측 차량 가격
#                 "damage_level": damage_level,  #손상 정도(없음, 심한 손상, 경미한 손상, 불확실한 손상상)
#                 "price_loss": price_loss,   #감가 금액
#                 "final_price": final_price,  # 최종 가격 (예측 차량 가격 - 감가)
#                 "deduction_reason": reason, #감가 이유
#                 "model_summary": model_summary   # 모델 요약
#             },
#             media_type="application/json; charset=utf-8"
#         )
#
#     except Exception as e:
#         #  상세 에러 로깅
#         traceback.print_exc()
#         return JSONResponse(
#             status_code=500,
#             content={"error": str(e)},
#             media_type="application/json; charset=utf-8"
#         )
#
#
#
#
# @router.get("/health")
# async def health_check():
#     try:
#         _ = price_model  # 가격 예측 모델 확인
#         _ = model  # 손상 모델 확인
#         return {"status": "healthy", "message": "모델 정상 작동 중"}
#     except Exception as e:
#         return {"status": "error", "detail": str(e)}