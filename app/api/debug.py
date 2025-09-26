# app/api/debug.py

from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.models.db_models import Business, Sector, Subsector, User, Deal, Role
from app.models.schemas import SubsectorCreate, SubsectorSchema

router = APIRouter()

# -----------------------------
# Debug endpoints for main tables
# -----------------------------

# ✅ Get all businesses
@router.get("/debug/businesses")
def get_businesses(db: Session = Depends(get_db)):
    return db.query(Business).all()



# ✅ Get all sectors
@router.get("/debug/sectors")
def get_sectors(db: Session = Depends(get_db)):
    return db.query(Sector).all()

# ✅ Get all subsectors
@router.get("/debug/subsectors")
def get_subsectors(db: Session = Depends(get_db)):
    return db.query(Subsector).all()

# ✅ Get all deals
@router.get("/debug/deals")
def get_deals(db: Session = Depends(get_db)):
    return db.query(Deal).all()

# ✅ Get all users
@router.get("/debug/users")
def get_users(db: Session = Depends(get_db)):
    return db.query(User).all()

# ✅ Get all roles
@router.get("/debug/roles")
def get_roles(db: Session = Depends(get_db)):
    return db.query(Role).all()

# ✅ Single route dumping IDs
@router.get("/debug/ids")
def get_all_ids(db: Session = Depends(get_db)):
    businesses = db.query(Business).all()
    return {
        "businesses": [{"id": b.id, "name": b.legal_name} for b in businesses],
        "sectors": [{"id": s.sector_id, "name": s.name} for s in sectors],
        "subsectors": [{"id": ss.subsector_id, "name": ss.name, "sector_id": ss.sector_id} for ss in subsectors]
    }

@router.post("/debug/subsectors", response_model=List[SubsectorSchema])
def create_subsectors(subsectors: List[SubsectorCreate], db: Session = Depends(get_db)):
    db_subsectors = []
    for subsector in subsectors:
        db_subsector = Subsector(**subsector.dict())
        db.add(db_subsector)
        db_subsectors.append(db_subsector)
    db.commit()
    for db_subsector in db_subsectors:
        db.refresh(db_subsector)
    return db_subsectors