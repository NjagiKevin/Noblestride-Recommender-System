from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.models.db_models import User
from app.models.schemas import UserResponse
from typing import List

router = APIRouter(prefix="/investors", tags=["Investors"])

@router.get("/", response_model=List[UserResponse])
def get_all_investors(db: Session = Depends(get_db)):
    return db.query(User).filter(User.role == 'Investor').all()

@router.get("/{investor_id}", response_model=UserResponse)
def get_investor(investor_id: int, db: Session = Depends(get_db)):
    investor = db.query(User).filter(User.id == investor_id, User.role == 'Investor').first()
    if not investor:
        raise HTTPException(status_code=404, detail="Investor not found")
    return investor
