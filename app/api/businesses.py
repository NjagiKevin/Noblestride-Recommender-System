from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from sqlalchemy.exc import IntegrityError
from app.models.db_models import Business
from app.models.schemas import BusinessCreate, BusinessResponse, UpsertResponse
from app.db.session import get_db
from app.services.recommender import add_business


router = APIRouter(prefix="/businesses", tags=["businesses"])


# ---- CREATE ----
@router.post("/", response_model=BusinessResponse)
def create_business(business: BusinessCreate, db: Session = Depends(get_db)):
    # First check if business already exists
    existing_business = db.query(Business).filter(
        Business.legal_name == business.legal_name,
        Business.location == business.location
    ).first()

    if existing_business:
        # If business exists, add to in-memory and return
        add_business(business)
        return existing_business

    # If not found, attempt to insert
    new_business = Business(**business.dict())
    db.add(new_business)

    try:
        db.commit()
        db.refresh(new_business)
        add_business(business)
        return new_business
    except IntegrityError:
        db.rollback()
        # This case handles rare race conditions
        existing_business = db.query(Business).filter(
            Business.legal_name == business.legal_name,
            Business.location == business.location
        ).first()
        if existing_business:
            add_business(business)
            return existing_business
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
