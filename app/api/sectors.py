# app/api/sectors.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
import uuid

from app.db.session import get_db
from app.models.db_models import Sector, Subsector
from app.models.schemas import SectorSchema, SubsectorSchema

router = APIRouter(prefix="/sectors", tags=["sectors"])

@router.get("/", response_model=List[SectorSchema])
def get_sectors(db: Session = Depends(get_db)):
    """
    Get all available sectors.
    """
    return db.query(Sector).all()

@router.get("/{sector_id}/subsectors", response_model=List[SubsectorSchema])
def get_subsectors_by_sector(sector_id: uuid.UUID, db: Session = Depends(get_db)):
    """
    Get all available subsectors for a given sector.
    """
    return db.query(Subsector).filter(Subsector.sector_id == sector_id).all()
