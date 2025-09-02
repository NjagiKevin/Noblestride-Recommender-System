# app/models/db_models.py
from sqlalchemy import Column,String, Float, JSON, UniqueConstraint
from app.db.session import Base

class Business(Base):
    __tablename__ = "businesses"

    id = Column(String, primary_key=True, index=True)
    legal_name = Column(String,nullable=False, index=True)
    sector = Column(String,nullable=True )
    industry = Column(String,nullable=True)
    location = Column(String, nullable=False)
    sub_sector = Column(String)
    countries = Column(JSON)
    region = Column(String)
    stage = Column(String)
    raise_min = Column(Float)
    raise_max = Column(Float)
    instruments = Column(JSON)
    impact_flags = Column(JSON)
    description = Column(String)
    core_service = Column(String)
    target_clients = Column(JSON)
    portfolio_keywords = Column(JSON)
    __table_args__ = (
    UniqueConstraint("legal_name", "location", name="uq_business_name_location"),
)
   
class Investor(Base):
    __tablename__ = "investors"

    id = Column(String, primary_key=True, index=True)
    fund_name = Column(String)
    sector_prefs = Column(JSON)
    stage_prefs = Column(JSON)
    countries_focus = Column(JSON)
    geo_regions = Column(JSON)
    countries_blocklist = Column(JSON)
    preferred_industries = Column(JSON)
    investment_range = Column(String)
    ticket_min = Column(Float)
    ticket_max = Column(Float)
    instruments = Column(JSON)
    impact_flags = Column(JSON)
    mandate_text = Column(String)
    track_record_text = Column(String)
    timeline_hint = Column(String)
