from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from PIL import Image
import numpy as np
import io
import json

from model_loader import predict
from schemas import PredictionResponse

app = FastAPI(title="Crop Disease Advisory API")

# Allow the frontend (running on a different address) to call this API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # tighten this to your real frontend URL before final deployment
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load the remedy database once at startup
with open("../data/remedies.json", encoding="utf-8") as f:
    _raw_remedies = json.load(f)

# Re-index by class_name instead of numeric string key
REMEDIES = {entry["class_name"]: entry for entry in _raw_remedies.values()}

def preprocess_image(file_bytes: bytes):
    image = Image.open(io.BytesIO(file_bytes)).convert("RGB")
    image = image.resize((224, 224))  # match whatever size the ML model was trained on
    array = np.array(image) / 255.0
    return np.expand_dims(array, axis=0)

@app.get("/")
def root():
    return {"status": "API is running"}

@app.post("/predict", response_model=PredictionResponse)
async def predict_disease(file: UploadFile = File(...)):
    content_type = file.content_type or ""
    if not content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File must be an image")

    file_bytes = await file.read()
    image_array = preprocess_image(file_bytes)

    disease, confidence = predict(image_array)
    remedy_data = REMEDIES.get(disease, {
        "remedy": "No remedy found",
        "remedy_hindi": "",
        "prevention": "",
        "prevention_hindi": ""
    })

    return PredictionResponse(
        disease=disease,
        confidence=confidence,
        remedy_en=remedy_data.get("remedy", ""),
        remedy_local=remedy_data.get("remedy_hindi", ""),
        prevention_local=remedy_data.get("prevention_hindi", ""),
    )