from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

from src.recomendation_service import schools_best_supplier

app = FastAPI()

class PredictInput (BaseModel):
    cie_list: List[int]

@app.post('/school_boards/suppliers/predict')
async def predict_supplier_for_school_board(body: PredictInput):
    return {"supplierCnpj": schools_best_supplier(body.cie_list)}

