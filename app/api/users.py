# app/api/users.py
from fastapi import APIRouter, Depends, status, HTTPException, Query
from sqlalchemy.orm import Session, joinedload
from typing import List,Optional
from sqlalchemy.exc import IntegrityError

from app.models.db_models import User, Role, Deal, Sector
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
def get_all_users(db: Session = Depends(get_db), role: str = None):
    """
    Get a list of users, optionally filtered by role.
    """
    query = db.query(User).options(joinedload(User.role_obj))
    if role:
        query = query.filter(User.role == role)
    return query.all()

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.models.db_models import User
from app.models.schemas import UserResponse, UserUpdate

@router.put("/users/{user_id}", response_model=UserResponse)
def update_user(user_id: int, user_update: UserUpdate, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.id == user_id).first()
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")
    
    update_data = user_update.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_user, field, value)
    
    db.commit()
    db.refresh(db_user)
    return db_user
@router.get("/sectors/")
def get_sectors(db: Session = Depends(get_db)):
    """
    Get all available sectors.
    """
    return db.query(Sector).all()

@router.get("/users")
async def get_users(role: Optional[str] = Query(None, description="Filter by role")):
    if role:
        users = await User.filter(role=role)  # only fetch users with that role
    else:
        users = await User.all()  # return all users if no filter
    
    return users