# app/models/db_models.py
from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Float,TIMESTAMP, func,
    Boolean,
    DateTime,
    ForeignKey,
    JSON,
)
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID, ENUM
import uuid
from datetime import datetime # Import datetime

from app.db.base import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, nullable=False, index=True)
    profile_image = Column(String(255))
    kyc_status = Column(ENUM('Pending', 'Verified', 'Rejected', name='enum_users_kyc_status'), default='Pending')
    password = Column(String(255), nullable=False)
    role = Column(ENUM('Investor', 'Administrator', 'Target Company', name='enum_users_role'), nullable=False, default='Investor')
    role_id = Column(UUID(as_uuid=True), ForeignKey('roles.role_id'), nullable=False)
    preference_sector = Column(JSON)
    description = Column(Text)
    location = Column(String(255))
    phone = Column(String(255))
    createdAt = Column(DateTime, nullable=False, default=datetime.utcnow)
    updatedAt = Column(DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow)
    deleted_at = Column(DateTime)
    parent_user_id = Column(Integer)

    # Relationships
    deals = relationship("Deal", foreign_keys="[Deal.created_by]", back_populates="created_by_user")
    targeted_deals = relationship("Deal", foreign_keys="[Deal.target_company_id]")
    role_obj = relationship("Role", back_populates="users")

class Deal(Base):
    __tablename__ = "deals"

    deal_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    title = Column(String(255), nullable=False)
    description = Column(Text, nullable=False)
    deal_size = Column(Float, nullable=False)
    project = Column(String, ForeignKey("businesses.id"))   # FK to Business
    sector_id = Column(UUID(as_uuid=True), ForeignKey("sectors.sector_id"))
    subsector_id = Column(UUID(as_uuid=True), ForeignKey("subsectors.subsector_id"))
    created_by = Column(Integer, ForeignKey("users.id"), nullable=False)
    target_company_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    status = Column(ENUM('Active', 'Pending', 'Open', 'On Hold', 'Inactive',
                         'Closed', 'Closed & Reopened', 'Archived',
                         name='enum_deals_status'), default='Open')
    visibility = Column(ENUM('Public', 'Private', name='enum_deals_visibility'), default='Public')
    deal_type = Column(ENUM('Equity', 'Debt', 'Equity and Debt', name='enum_deals_deal_type'))
    createdAt = Column(DateTime, default=datetime.utcnow)
    updatedAt = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    business = relationship("Business", back_populates="deals")
    sector = relationship("Sector", back_populates="deals")
    subsector = relationship("Subsector", back_populates="deals")
    created_by_user = relationship("User", foreign_keys=[created_by], back_populates="deals")
    target_company = relationship("User", foreign_keys=[target_company_id], back_populates="targeted_deals")

    
class Sector(Base):
    __tablename__ = "sectors"
    sector_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String(255), nullable=False, unique=True)
    createdAt = Column(DateTime, nullable=False, default=datetime.utcnow)
    updatedAt = Column(DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow)

    deals = relationship("Deal", back_populates="sector")
    subsectors = relationship("Subsector", back_populates="sector")
    businesses = relationship("Business", primaryjoin="foreign(Business.sector) == Sector.name", back_populates="sector_rel")

class Subsector(Base):
    __tablename__ = "subsectors"
    subsector_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String(255), nullable=False)
    sector_id = Column(UUID(as_uuid=True), ForeignKey('sectors.sector_id'), nullable=False)
    createdAt = Column(DateTime, nullable=False, default=datetime.utcnow)
    updatedAt = Column(DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow)

    sector = relationship("Sector", back_populates="subsectors")
    deals = relationship("Deal", back_populates="subsector")
    businesses = relationship("Business", primaryjoin="foreign(Business.sub_sector) == Subsector.name", back_populates="subsector_rel")

class Role(Base):
    __tablename__ = "roles"
    role_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String(255), nullable=False, unique=True)
    createdAt = Column(DateTime, nullable=False, default=datetime.utcnow)
    updatedAt = Column(DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow)

    users = relationship("User", back_populates="role_obj")

class Business(Base):
    __tablename__ = "businesses"

    id = Column(String, primary_key=True, index=True)
    legal_name = Column(String, nullable=True)
    sector = Column(String, nullable=True)
    industry = Column(String, nullable=True)
    location = Column(String, nullable=True)
    sub_sector = Column(String, nullable=True)
    countries = Column(JSON, nullable=True)
    region = Column(String, nullable=True)
    stage = Column(String, nullable=True)
    raise_min = Column(Float, nullable=True)
    raise_max = Column(Float, nullable=True)
    instruments = Column(JSON, nullable=True)
    impact_flags = Column(JSON, nullable=True)
    description = Column(String, nullable=True)
    core_service = Column(String, nullable=True)
    target_clients = Column(JSON, nullable=True)
    portfolio_keywords = Column(JSON, nullable=True)
    capital_needed = Column(Float, nullable=True)

    createdAt = Column(
        "createdAt", TIMESTAMP(timezone=False),
        server_default=func.now(), nullable=False
    )
    updatedAt = Column(
        "updatedAt", TIMESTAMP(timezone=False),
        server_default=func.now(), onupdate=func.now(), nullable=False
    )
    deals = relationship("Deal", back_populates="business")
    sector_rel = relationship("Sector", primaryjoin="foreign(Business.sector) == Sector.name", back_populates="businesses")
    subsector_rel = relationship("Subsector", primaryjoin="foreign(Business.sub_sector) == Subsector.name", back_populates="businesses")
   


class Investor(Base):
    __tablename__ = "investors"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, nullable=False, index=True)
    description = Column(Text)
    location = Column(String(255))
    preference_sector = Column(JSON)
    createdAt = Column(DateTime, nullable=False, default=datetime.utcnow)
    updatedAt = Column(DateTime, nullable=False, default=datetime.utcnow, onupdate=datetime.utcnow)
