# app/api/users.py
from fastapi import APIRouter, Depends, status, HTTPException, Query
from sqlalchemy.orm import Session, joinedload
from typing import List,Optional
from sqlalchemy.exc import IntegrityError

from app.models.db_models import User, Role, Deal, Sector
from app.models.schemas import UserResponse, UserCreate
from app.db.session import get_db

router = APIRouter(prefix="/users", tags=["users"])

@router.post("", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
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

@router.post("/bulk", response_model=List[UserResponse], status_code=status.HTTP_201_CREATED)
def bulk_create_users(users: List[UserCreate], db: Session = Depends(get_db)):
    """
    Create multiple users (investors, target companies, etc.) in a single request.
    """
    created_users = []
    for user in users:
        # Check if user with this email already exists
        existing_user = db.query(User).filter(User.email == user.email).first()
        if existing_user:
            # Skip existing users or handle as an error, for now, we'll skip
            print(f"User with email {user.email} already exists, skipping.")
            continue

        # Find the role_id based on the role name
        role_obj = db.query(Role).filter(Role.name == user.role).first()
        if not role_obj:
            print(f"Role '{user.role}' not found for user {user.email}, skipping.")
            continue

        db_user = User(**user.dict())
        db_user.role_id = role_obj.role_id # Assign the role_id

        db.add(db_user)
        created_users.append(db_user)
    
    try:
        db.commit()
        for user_obj in created_users:
            db.refresh(user_obj)
        return created_users
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Could not create some users due to data integrity issue.")
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"An unexpected error occurred during bulk user creation: {str(e)}")

@router.get("", response_model=List[UserResponse])
def get_all_users(db: Session = Depends(get_db), role: str = None):
    """
    Get a list of users, optionally filtered by role.
    """
    query = db.query(User).options(joinedload(User.role_obj))
    if role:
        query = query.filter(User.role == role)
    return query.all()

