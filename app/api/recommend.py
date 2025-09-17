from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from typing import List

from app.db.session import get_db
from app.models.schemas import (
    BusinessCreate,
    RankedUserResponse,
    RankInvestorsRequest,
    RankedUser,
    BusinessResponse,
    UserResponse,
    DealResponse,
)
from app.services.recommender import recommend_investors_for_business, recommend_deals_for_user, recommend_businesses_for_investor
from app.models.db_models import Business, User, Deal, Sector

router = APIRouter(prefix="/recommend", tags=["recommendations"])

# Toggle this when moving from dev → prod
DEBUG = True

@router.post("/businesses/{business_id}/recommended-investors", response_model=RankedUserResponse)
def get_investor_recommendations_for_business(
    business_id: str,
    request: RankInvestorsRequest,
    db: Session = Depends(get_db)
):
    """
    Recommend investors for a given business.
    """
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")

    business_data = {
        "id": business.id,
        "legal_name": business.legal_name,
        "sector": business.sector,
        "industry": business.industry,
        "location": business.location,
        "sub_sector": business.sub_sector,
        "countries": business.countries,
        "region": business.region,
        "stage": business.stage,
        "raise_min": business.raise_min,
        "raise_max": business.raise_max,
        "instruments": business.instruments,
        "impact_flags": business.impact_flags,
        "description": business.description,
        "core_service": business.core_service,
        "target_clients": business.target_clients,
        "portfolio_keywords": business.portfolio_keywords,
        "capital_needed": business.capital_needed,
        "createdAt": business.createdAt,
        "updatedAt": business.updatedAt,
    }
    business_create = BusinessCreate(**business_data)

    try:
        rankings = recommend_investors_for_business(db, business_create, top_n=request.top_k)

        response_items = []
        for item in rankings:
            user_obj = (
                db.query(User)
                .options(joinedload(User.role_obj))
                .filter(User.id == item['user_id'])
                .first()
            )
            if user_obj:
                response_items.append(
                    RankedUser(reasons=item['reasons'], user=user_obj)
                )

        return RankedUserResponse(items=response_items)

    except Exception as e:
        print(f"Error recommending investors: {e}")  # dev logging

        if DEBUG:
            raise HTTPException(status_code=500, detail=f"Unexpected error: {str(e)}")
        else:
            raise HTTPException(status_code=500, detail="An unexpected error occurred.")


@router.post("/investors-for-business", response_model=RankedUserResponse)
def get_investors_for_business(
    business: BusinessCreate,
    request: RankInvestorsRequest,
    db: Session = Depends(get_db)
):
    """
    Get investor recommendations for a business based on matching criteria.
    """
    try:
        rankings = recommend_investors_for_business(db, business, top_n=request.top_k)

        response_items = []
        for item in rankings:
            user_obj = (
                db.query(User)
                .options(joinedload(User.role_obj))
                .filter(User.id == item['user_id'])
                .first()
            )
            if user_obj:
                response_items.append(
                    RankedUser(reasons=item['reasons'], user=user_obj)
                )

        return RankedUserResponse(items=response_items)
    except Exception as e:
        print(f"Error recommending investors: {e}")  # dev logging

        if DEBUG:
            # Show raw error details during development
            raise HTTPException(status_code=500, detail=f"Unexpected error: {str(e)}")
        else:
            # Generic message for production
            raise HTTPException(status_code=500, detail="An unexpected error occurred.")

# ✅ Recommend businesses for a given investor
@router.get("/businesses/{investor_id}", response_model=List[BusinessResponse])
def get_recommended_businesses_for_investor(investor_id: int, db: Session = Depends(get_db)):
    try:
        recommended_businesses_data = recommend_businesses_for_investor(db, investor_id) # This now calls the service function

        businesses_response_list = []
        for business_data in recommended_businesses_data:
            business_obj = db.query(Business).filter(Business.id == business_data['business_id']).first()
            if business_obj:
                businesses_response_list.append(business_obj)
        return businesses_response_list
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        print(f"Error recommending businesses: {e}") # dev logging
        if DEBUG:
            raise HTTPException(status_code=500, detail=f"Unexpected error: {str(e)}")
        else:
            raise HTTPException(status_code=500, detail="An unexpected error occurred.")


# ✅ Recommend investors for a given business
@router.get("/investors/{business_id}", response_model=List[UserResponse])
def get_investors_for_business_by_id(business_id: str, db: Session = Depends(get_db)):
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")

    all_investors = db.query(User).filter(User.role == "Investor").all()
    
    recommended_investors = []
    for investor in all_investors:
        if investor.preference_sector and business.sector in investor.preference_sector:
            recommended_investors.append(investor)

    return recommended_investors


# ✅ Recommend deals for a given investor
@router.get("/deals/{investor_id}", response_model=List[DealResponse])
def recommend_deals_for_investor(investor_id: int, db: Session = Depends(get_db)):
    try:
        recommended_deals_data = recommend_deals_for_user(db, investor_id)

        # The service returns a list of dicts. We need to convert these to DealResponse objects.
        # Assuming DealResponse can be directly instantiated from the Deal ORM model.
        # We'll fetch the full Deal object using the deal_id from the recommended data.
        deals_response_list = []
        for deal_data in recommended_deals_data:
            deal_obj = db.query(Deal).filter(Deal.deal_id == deal_data['deal_id']).first()
            if deal_obj:
                deals_response_list.append(deal_obj)
        return deals_response_list
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        print(f"Error recommending deals: {e}") # dev logging
        if DEBUG:
            raise HTTPException(status_code=500, detail=f"Unexpected error: {str(e)}")
        else:
            raise HTTPException(status_code=500, detail="An unexpected error occurred.")

@router.get("/test")
def test_endpoint():
    return {"hello": "world"}