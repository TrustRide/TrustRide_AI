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

# 업로드 디렉토리 설정
UPLOAD_DIR = "C:/upload"
os.makedirs(UPLOAD_DIR, exist_ok=True)

# 모델 파일 경로
DAMAGE_MODEL_PATH = "predict_router/models/damage_model.pth"
PRICE_MODEL_PATH = "predict_router/models/lgbm_price_model.json"
SCALER_PATH = "predict_router/models/scaler.pkl"
VECTORIZER_PATH = "predict_router/models/vectorizer.pkl"
BRAND_ENCODER_PATH = "predict_router/models/brand_encoder.pkl"
FUEL_ENCODER_PATH = "predict_router/models/fuel_encoder.pkl"
VEHICLE_TYPE_ENCODER_PATH = "predict_router/models/vehicle_type_encoder.pkl"
TRIM_ENCODER_PATH = "predict_router/models/trim_encoder.pkl"

# 손상 모델 로드 (PyTorch)
try:
    device = torch.device("cpu")
    model = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)
    model.fc = torch.nn.Linear(model.fc.in_features, 2)
    model.load_state_dict(torch.load(DAMAGE_MODEL_PATH, map_location=device))
    model.eval()
except Exception as e:
    print(f"Error loading damage model: {str(e)}")
    raise

# 가격 예측 모델 및 전처리 모델 로드
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

# 이미지 전처리
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

        model_summary = f"{model_name} {trim_summary}"
        X_text = vectorizer.transform([model_summary])

        brand_encoded = brand_encoder.transform([brand])[0]
        fuel_encoded = fuel_encoder.transform([fuel_type])[0]
        vehicle_type_encoded = vehicle_type_encoder.transform([vehicle_type])[0]
        trim_encoded = trim_encoder.transform([trim_summary])[0]

        X_num = np.array([[year, km_driven]])
        X_num_scaled = scaler.transform(X_num)
        year_scaled, km_driven_scaled = X_num_scaled[0]

        X_other = np.array([[brand_encoded, fuel_encoded, vehicle_type_encoded, trim_encoded, year_scaled, km_driven_scaled]])
        X_other_sparse = csr_matrix(X_other)
        X_all = hstack([X_text, X_other_sparse])

        # ✅ Booster 모델은 predict에서 raw_score=False로 설정
        predicted_price = int(price_model.predict(X_all, raw_score=False)[0])

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
