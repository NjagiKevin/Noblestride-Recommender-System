# app/api/ranking.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import uuid

from app.models.schemas import (
    RankDealsRequest,
    RankInvestorsRequest,
    RankedDealResponse,
    RankedUserResponse,
    RankedDeal,
    RankedUser,
)
from app.db.session import get_db
from app.services.recommender import recommend_deals_for_user, recommend_investors_for_deal
from app.models.db_models import User, Deal

router = APIRouter(prefix="/rank", tags=["ranking"])

@router.post("/users/{user_id}/recommended-deals", response_model=RankedDealResponse)
def get_deal_recommendations_for_user(user_id: int, request: RankDealsRequest, db: Session = Depends(get_db)):
    """
    Recommend deals for a given user (investor).
    """
    try:
        rankings = recommend_deals_for_user(db=db, user_id=user_id, top_n=request.top_k)
        
        response_items = []
        for item in rankings:
            deal_obj = db.query(Deal).filter(Deal.deal_id == item['deal_id']).first()
            if deal_obj:
                response_items.append(
                    RankedDeal(reasons=item['reasons'], deal=deal_obj)
                )
        
        return RankedDealResponse(items=response_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating deal recommendations: {str(e)}")

@router.post("/deals/{deal_id}/recommended-investors", response_model=RankedUserResponse)
def get_investor_recommendations_for_deal(deal_id: uuid.UUID, request: RankInvestorsRequest, db: Session = Depends(get_db)):
    """
    Recommend investors for a given deal.
    """
    try:
        rankings = recommend_investors_for_deal(db=db, deal_id=deal_id, top_n=request.top_k)
        
        response_items = []
        for item in rankings:
            user_obj = db.query(User).filter(User.id == item['user_id']).first()
            if user_obj:
                response_items.append(
                    RankedUser(reasons=item['reasons'], user=user_obj)
                )

        return RankedUserResponse(items=response_items)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating investor recommendations: {str(e)}")
