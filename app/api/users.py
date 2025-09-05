# app/api/users.py
from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session, joinedload
from typing import List
from sqlalchemy.exc import IntegrityError

from app.models.db_models import User, Role
from app.models.schemas import UserResponse, UserCreate
from app.db.session import get_db

router = APIRouter(prefix="/users", tags=["users"])

@router.post("/", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    # Check if user with this email already exists
    existing_user = db.query(User).filter(User.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="User with this email already exists")

    # Find the role_id based on the role name
    role_obj = db.query(Role).filter(Role.name == user.role).first()
    if not role_obj:
        raise HTTPException(status_code=400, detail=f"Role '{user.role}' not found.")

    db_user = User(**user.dict())
    db_user.role_id = role_obj.role_id # Assign the role_id

    db.add(db_user)
    try:
        db.commit()
        db.refresh(db_user)
        return db_user
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Could not create user due to data integrity issue.")

@router.get("/", response_model=List[UserResponse])
def get_all_users(db: Session = Depends(get_db)):
    """
    Get a list of the first 10 users.
    """
    return db.query(User).options(joinedload(User.role_obj)).limit(10).all()
