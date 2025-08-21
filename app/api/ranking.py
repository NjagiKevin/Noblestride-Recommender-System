# app/api/ranking.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.models.schemas import RankInvestorsRequest, RankDealsRequest, RankResponse, RankedItem
from app.db.session import get_db
from app.services.recommender import generate_rankings

router = APIRouter(prefix="/rank", tags=["ranking"])

@router.post("/businesses/{investor_id}", response_model=RankResponse)
def recommend_businesses_for_investor(investor_id: str, request: RankDealsRequest, db: Session = Depends(get_db)):
    """
    Recommend businesses for a given investor.
    """
    try:
        rankings = generate_rankings(investor_id=investor_id, db=db, mode="investor_to_business")
        return {"items": rankings}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating business recommendations: {str(e)}")

@router.post("/investors/{business_id}", response_model=RankResponse)
def recommend_investors_for_business(business_id: str, request: RankInvestorsRequest, db: Session = Depends(get_db)):
    """
    Recommend investors for a given business.
    """
    try:
        rankings = generate_rankings(business_id=business_id, db=db, mode="business_to_investor")
        return {"items": rankings}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating investor recommendations: {str(e)}")
