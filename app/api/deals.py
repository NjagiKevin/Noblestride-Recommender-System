# app/api/deals.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session, joinedload
from typing import List

from app.models.db_models import Deal
from app.models.schemas import DealResponse
from app.db.session import get_db

router = APIRouter(prefix="/deals", tags=["deals"])

@router.get("/", response_model=List[DealResponse])
def get_all_deals(db: Session = Depends(get_db)):
    """
    Get a list of the first 10 deals.
    """
    return db.query(Deal).options(joinedload(Deal.created_by_user)).limit(10).all()