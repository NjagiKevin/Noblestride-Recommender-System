# app/api/deals.py
from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session, joinedload
from typing import List
from sqlalchemy.exc import IntegrityError

from app.models.db_models import Deal
from app.models.schemas import DealResponse, DealCreate
from app.db.session import get_db

router = APIRouter(prefix="/deals", tags=["deals"])

@router.post("/", response_model=DealResponse, status_code=status.HTTP_201_CREATED)
def create_deal(deal: DealCreate, db: Session = Depends(get_db)):
    # Check if deal with this title and created_by already exists
    existing_deal = db.query(Deal).filter(
        Deal.title == deal.title,
        Deal.created_by == deal.created_by
    ).first()
    if existing_deal:
        raise HTTPException(status_code=400, detail="Deal with this title and creator already exists")

    db_deal = Deal(**deal.dict())
    db.add(db_deal)
    try:
        db.commit()
        db.refresh(db_deal)
        return db_deal
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Could not create deal due to data integrity issue.")

@router.get("/", response_model=List[DealResponse])
def get_all_deals(db: Session = Depends(get_db)):
    """
    Get a list of the first 10 deals.
    """
    return (
        db.query(Deal)
        .options(
            joinedload(Deal.created_by_user),
            joinedload(Deal.sector),
            joinedload(Deal.subsector),
        )
        .limit(10)
        .all()
    )