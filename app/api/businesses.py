from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from sqlalchemy.exc import IntegrityError
from app.models.db_models import Business
from app.models.schemas import BusinessCreate, BusinessResponse, UpsertResponse
from app.db.session import get_db


router = APIRouter(prefix="/businesses", tags=["businesses"])


# ---- CREATE ----
@router.post("/", response_model=BusinessResponse)
def create_business(business: BusinessCreate, db: Session = Depends(get_db)):
    # First check if business already exists
    existing = db.query(Business).filter(
        Business.legal_name == business.legal_name,
        Business.location == business.location
    ).first()

    if existing:
        # ✅ Return the existing one (instead of failing)
        return existing

    # If not found, attempt to insert
    new_business = Business(**business.dict())
    db.add(new_business)

    try:
        db.commit()
        db.refresh(new_business)
        return new_business
    except IntegrityError:
        db.rollback()
        # ✅ If DB rejects it (unique constraint violation),
        #    fetch & return the existing business anyway
        existing = db.query(Business).filter(
            Business.legal_name == business.legal_name,
            Business.location == business.location
        ).first()
        if existing:
            return existing
        raise HTTPException(status_code=400, detail="Could not create business")

# ---- READ ALL ----
@router.get("/", response_model=List[BusinessResponse])
def get_all_businesses(db: Session = Depends(get_db)):
    return db.query(Business).all()


# ---- READ ONE ----
@router.get("/{business_id}", response_model=BusinessResponse)
def get_business_by_id(business_id: int, db: Session = Depends(get_db)):
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
    return business


# ---- UPDATE ----
@router.put("/{business_id}", response_model=BusinessResponse)
def update_business(business_id: str, business_update: BusinessCreate, db: Session = Depends(get_db)):
                                                                                             
    for field, value in business_update.dict().items():
        setattr(business, field, value)

    db.commit()
    db.refresh(business)
    return business


# ---- DELETE ----
@router.delete("/{business_id}", response_model=UpsertResponse)
def delete_business(business_id: str, db: Session = Depends(get_db)):
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")

    db.delete(business)
    db.commit()
    return {"ok": True, "count": 1}
