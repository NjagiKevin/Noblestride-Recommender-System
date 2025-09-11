# app/api/investors.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from sqlalchemy.exc import IntegrityError

from app.models.db_models import Investor
from app.models.schemas import InvestorCreate, InvestorResponse, UpsertResponse
from app.db.session import get_db

router = APIRouter(prefix="/investors", tags=["investors"])

# ---- CREATE ----
@router.post("/", response_model=InvestorResponse, status_code=status.HTTP_201_CREATED)
def create_investor(investor: InvestorCreate, db: Session = Depends(get_db)):
    # First check if investor already exists
    existing_investor = db.query(Investor).filter(Investor.id == investor.id).first()

    if existing_investor:
        # If investor exists, add to in-memory and return
        return existing_investor

    # If not found, attempt to insert
    db_investor = Investor(**investor.dict())
    db.add(db_investor)

    try:
        db.commit()
        db.refresh(db_investor)
        return db_investor
    except IntegrityError:
        db.rollback()
        # This case handles rare race conditions
        existing_investor = db.query(Investor).filter(Investor.id == investor.id).first()
        if existing_investor:
            return existing_investor
        raise HTTPException(status_code=400, detail="Could not create investor")

# ---- READ ALL ----
@router.get("/", response_model=List[InvestorResponse])
def get_all_investors(db: Session = Depends(get_db)):
    return db.query(Investor).all()

# ---- READ ONE ----
@router.get("/{investor_id}", response_model=InvestorResponse)
def get_investor_by_id(investor_id: str, db: Session = Depends(get_db)):
    investor = db.query(Investor).filter(Investor.id == investor_id).first()
    if not investor:
        raise HTTPException(status_code=404, detail="Investor not found")
    return investor

# ---- UPDATE ----
@router.put("/{investor_id}", response_model=InvestorResponse)
def update_investor(investor_id: str, investor_update: InvestorCreate, db: Session = Depends(get_db)):
    investor = db.query(Investor).filter(Investor.id == investor_id).first()
    if not investor:
        raise HTTPException(status_code=404, detail="Investor not found")

    for field, value in investor_update.dict().items():
        setattr(investor, field, value)

    db.commit()
    db.refresh(investor)
    return investor

# ---- DELETE ----
@router.delete("/{investor_id}", response_model=UpsertResponse)
def delete_investor(investor_id: str, db: Session = Depends(get_db)):
    investor = db.query(Investor).filter(Investor.id == investor_id).first()
    if not investor:
        raise HTTPException(status_code=404, detail="Investor not found")

    db.delete(investor)
    db.commit()
    return {"ok": True, "count": 1}