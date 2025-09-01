from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from sqlalchemy.exc import IntegrityError
from app.models.db_models import Business
from app.models.schemas import BusinessCreate, BusinessResponse, UpsertResponse
from app.db.session import get_db


router = APIRouter(prefix="/businesses", tags=["businesses"])


# ---- CREATE ----
@router.post("/", response_model=BusinessResponse, status_code=status.HTTP_201_CREATED) 
def create_business(business: BusinessCreate, db: Session = Depends(get_db)):
    db_business = Business(**business.dict())
    db.add(db_business)
    try:
        db.commit()
        db.refresh(db_business)
    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=409,
            detail="Business with this legal name and location already exists"
        )
    return db_business


# ---- READ ALL ----
@router.get("/", response_model=List[BusinessResponse])
def get_all_businesses(db: Session = Depends(get_db)):
    return db.query(Business).all()


# ---- READ ONE ----
@router.get("/{business_id}", response_model=BusinessResponse)
def get_business_by_id(business_id: str, db: Session = Depends(get_db)):
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")
    return business


# ---- UPDATE ----
@router.put("/{business_id}", response_model=BusinessResponse)
def update_business(business_id: str, business_update: BusinessCreate, db: Session = Depends(get_db)):
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise HTTPException(status_code=404, detail="Business not found")

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
