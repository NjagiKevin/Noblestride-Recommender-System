# app/api/users.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

from app.models.db_models import User
from app.models.schemas import UserResponse
from app.db.session import get_db

router = APIRouter(prefix="/users", tags=["users"])

@router.get("/", response_model=List[UserResponse])
def get_all_users(db: Session = Depends(get_db)):
    """
    Get a list of the first 10 users.
    """
    return db.query(User).limit(10).all()
