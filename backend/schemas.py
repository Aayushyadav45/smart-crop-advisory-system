from pydantic import BaseModel

class PredictionResponse(BaseModel):
    disease: str
    confidence: float
    remedy_en: str
    remedy_local: str
    prevention_local: str