# app/api/ranking.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.models.schemas import (
    RankInvestorsRequest,
    RankDealsRequest,
    RankedBusinessResponse,
    RankedInvestorResponse,
    RankedBusiness,
    RankedInvestor,
)
from app.db.session import get_db
from app.services.recommender import generate_rankings, recommend_investors_for_business
from app.models.db_models import Business, Investor

router = APIRouter(prefix="/rank", tags=["ranking"])

@router.post("/businesses/{investor_id}", response_model=RankedBusinessResponse)
def recommend_businesses_for_investor(investor_id: str, request: RankDealsRequest, db: Session = Depends(get_db)):
    """
    Recommend businesses for a given investor, returning full details and reasons.
    """
    try:
        rankings = generate_rankings(db=db, investor_id=investor_id, top_n=request.top_k)
        
        response_items = []
        for item in rankings:
            business_obj = db.query(Business).filter(Business.id == item['business_id']).first()
            if business_obj:
                response_items.append(
                    RankedBusiness(reasons=item['reasons'], business=business_obj)
                )
        
        return RankedBusinessResponse(items=response_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating business recommendations: {str(e)}")

@router.post("/investors/{business_id}", response_model=RankedInvestorResponse)
def recommend_investors_for_business_endpoint(business_id: str, request: RankInvestorsRequest, db: Session = Depends(get_db)):
    """
    Recommend investors for a given business, returning full details and reasons.
    """
    try:
        rankings = recommend_investors_for_business(db=db, business_id=business_id, top_n=request.top_k)
        
        response_items = []
        for item in rankings:
            investor_obj = db.query(Investor).filter(Investor.id == item['investor_id']).first()
            if investor_obj:
                response_items.append(
                    RankedInvestor(reasons=item['reasons'], investor=investor_obj)
                )

        return RankedInvestorResponse(items=response_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating investor recommendations: {str(e)}")