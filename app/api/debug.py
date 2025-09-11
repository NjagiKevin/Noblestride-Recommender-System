# app/api/debug.py

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.models.db_models import Business, Investor, Sector, Subsector, User, Deal, Role

router = APIRouter()

# -----------------------------
# Debug endpoints for main tables
# -----------------------------

# ✅ Get all businesses
@router.get("/debug/businesses")
def get_businesses(db: Session = Depends(get_db)):
    return db.query(Business).all()

# ✅ Get all investors
@router.get("/debug/investors")
def get_investors(db: Session = Depends(get_db)):
    return db.query(Investor).all()

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
    investors = db.query(Investor).all()
    sectors = db.query(Sector).all()
    subsectors = db.query(Subsector).all()

    return {
        "businesses": [{"id": b.id, "name": b.legal_name} for b in businesses],
        "investors": [{"id": i.id, "name": i.name} for i in investors],
        "sectors": [{"id": s.sector_id, "name": s.name} for s in sectors],
        "subsectors": [{"id": ss.subsector_id, "name": ss.name, "sector_id": ss.sector_id} for ss in subsectors]
    }
