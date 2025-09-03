# app/api/ranking.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.models.schemas import RankInvestorsRequest, RankDealsRequest, RankResponse, RankedItem
from app.db.session import get_db
from app.services.recommender import generate_rankings, recommend_investors_for_business

router = APIRouter(prefix="/rank", tags=["ranking"])

@router.post("/businesses/{investor_id}", response_model=RankResponse)
def recommend_businesses_for_investor(investor_id: str, request: RankDealsRequest, db: Session = Depends(get_db)):
    """
    Recommend businesses for a given investor.
    """
    try:
        rankings = generate_rankings(db=db, investor_id=investor_id, top_n=request.top_k)
        ranked_items = [RankedItem(id=item['business_id'], score=item['match_score'], reasons=[]) for item in rankings]
        return RankResponse(items=ranked_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating business recommendations: {str(e)}")

@router.post("/investors/{business_id}", response_model=RankResponse)
def recommend_investors_for_business_endpoint(business_id: str, request: RankInvestorsRequest, db: Session = Depends(get_db)):
    """
    Recommend investors for a given business.
    """
    try:
        rankings = recommend_investors_for_business(db=db, business_id=business_id, top_n=request.top_k)
        ranked_items = [RankedItem(id=item['investor_id'], score=item['match_score'], reasons=[]) for item in rankings]
        return RankResponse(items=ranked_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating investor recommendations: {str(e)}")
