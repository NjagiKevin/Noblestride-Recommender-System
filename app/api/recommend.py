from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.db.session import get_db
from app.models.schemas import BusinessCreate, InvestorResponse # Corrected imports
from app.services.recommender import recommend_investors_for_business # Corrected import

router = APIRouter(prefix="/recommend", tags=["recommendations"])

@router.post("/investors-for-business", response_model=List[InvestorResponse])
def get_investors_for_business(business: BusinessCreate, db: Session = Depends(get_db)):
    """
    Get investor recommendations for a business based on matching criteria.
    """
    try:
        investors = recommend_investors_for_business(db, business)

        if not investors:
            raise HTTPException(status_code=404, detail="No matching investors found for the given criteria.")

        return investors
    except Exception as e:
        # Log the error for debugging, don't expose raw errors in production
        print(f"Error recommending investors: {e}")
        raise HTTPException(status_code=500, detail=f"An unexpected error occurred: {str(e)}")