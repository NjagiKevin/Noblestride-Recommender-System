# app/api/deals.py
from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session, joinedload
from typing import List
from sqlalchemy.exc import IntegrityError
import uuid

from app.models.db_models import Deal, Sector, Subsector
from app.models.schemas import DealResponse, DealCreate, DealStatusUpdate
from app.db.session import get_db

router = APIRouter(prefix="/deals", tags=["deals"])


# Single deal
@router.post("/", response_model=DealResponse, status_code=status.HTTP_201_CREATED)
def create_deal(deal: DealCreate, db: Session = Depends(get_db)):
    existing_deal = db.query(Deal).filter(
        Deal.title == deal.title,
        Deal.created_by == deal.created_by
    ).first()
    if existing_deal:
        raise HTTPException(status_code=400, detail="Deal with this title and creator already exists")

    # Validate sector_id exists
    sector = db.query(Sector).filter(Sector.sector_id == deal.sector_id).first()
    if not sector:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid sector_id: {deal.sector_id} does not exist in database"
        )

    # Validate subsector_id exists
    if deal.subsector_id:
        subsector = db.query(Subsector).filter(Subsector.subsector_id == deal.subsector_id).first()
        if not subsector:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid subsector_id: {deal.subsector_id} does not exist in database"
            )

    db_deal = Deal(**deal.dict())
    db.add(db_deal)
    try:
        db.commit()
        db.refresh(db_deal)
        return db_deal
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Could not create deal due to data integrity issue.")


# Bulk deals
@router.post("/bulk", response_model=List[DealResponse], status_code=status.HTTP_201_CREATED)
def create_bulk_deals(deals: List[DealCreate], db: Session = Depends(get_db)):
    db_deals = []

    for deal in deals:
        # Validate sector_id exists
        sector = db.query(Sector).filter(Sector.sector_id == deal.sector_id).first()
        if not sector:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid sector_id: {deal.sector_id} does not exist in database"
            )

        # Validate subsector_id exists
        if deal.subsector_id:
            subsector = db.query(Subsector).filter(Subsector.subsector_id == deal.subsector_id).first()
            if not subsector:
                raise HTTPException(
                    status_code=400,
                    detail=f"Invalid subsector_id: {deal.subsector_id} does not exist in database"
                )

        # Check for duplicate title+creator
        existing_deal = db.query(Deal).filter(
            Deal.title == deal.title,
            Deal.created_by == deal.created_by
        ).first()
        if existing_deal:
            raise HTTPException(
                status_code=400,
                detail=f"Deal with title '{deal.title}' and creator {deal.created_by} already exists"
            )

        db_deal = Deal(**deal.dict())
        db.add(db_deal)
        db_deals.append(db_deal)

    try:
        db.commit()
        for d in db_deals:
            db.refresh(d)
        return db_deals
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Could not create some deals due to data integrity issues.")
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# Get deals
@router.get("/", response_model=List[DealResponse])
def get_all_deals(db: Session = Depends(get_db)):
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

@router.put("/{deal_id}/status", response_model=DealResponse)
def update_deal_status(deal_id: uuid.UUID, status_update: DealStatusUpdate, db: Session = Depends(get_db)):
    deal = db.query(Deal).filter(Deal.deal_id == deal_id).first()
    if not deal:
        raise HTTPException(status_code=404, detail="Deal not found")

    deal.status = status_update.status
    db.commit()
    db.refresh(deal)
    return deal
