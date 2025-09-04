# app/models/db_models.py
from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Float,
    Boolean,
    DateTime,
    ForeignKey,
    JSON,
)
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID, ENUM
import uuid
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
    preference_sector = Column(JSON)
    preference_sector = Column(JSON)
    description = Column(Text)
    location = Column(String(255))
    phone = Column(String(255))
    createdAt = Column(DateTime, nullable=False)
    updatedAt = Column(DateTime, nullable=False)
    deleted_at = Column(DateTime)
    parent_user_id = Column(Integer)

    # Relationships
    deals = relationship("Deal", back_populates="created_by_user")

class Deal(Base):
    __tablename__ = "deals"

    deal_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    title = Column(String(255), nullable=False)
    project = Column(String(255))
    description = Column(Text, nullable=False)
    image_url = Column(String(255))
    status = Column(ENUM('Active', 'Pending', 'Open', 'On Hold', 'Inactive', 'Closed', 'Closed & Reopened', 'Archived', name='enum_deals_status'), nullable=False, default='Open')
    deal_size = Column(Float, nullable=False)
    sector_id = Column(UUID(as_uuid=True), ForeignKey('sectors.sector_id'))
    subsector_id = Column(UUID(as_uuid=True), ForeignKey('subsectors.subsector_id'))
    created_by = Column(Integer, ForeignKey('users.id'), nullable=False)
    visibility = Column(ENUM('Public', 'Private', name='enum_deals_visibility'), default='Public')
    deal_type = Column(ENUM('Equity', 'Debt', 'Equity and Debt', name='enum_deals_deal_type'))
    createdAt = Column(DateTime, nullable=False)
    updatedAt = Column(DateTime, nullable=False)

    # Relationships
    created_by_user = relationship("User", back_populates="deals")
    sector = relationship("Sector", back_populates="deals")
    subsector = relationship("Subsector", back_populates="deals")

class Sector(Base):
    __tablename__ = "sectors"
    sector_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String(255), nullable=False, unique=True)
    createdAt = Column(DateTime, nullable=False)
    updatedAt = Column(DateTime, nullable=False)

    deals = relationship("Deal", back_populates="sector")
    subsectors = relationship("Subsector", back_populates="sector")

class Subsector(Base):
    __tablename__ = "subsectors"
    subsector_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String(255), nullable=False)
    sector_id = Column(UUID(as_uuid=True), ForeignKey('sectors.sector_id'), nullable=False)
    createdAt = Column(DateTime, nullable=False)
    updatedAt = Column(DateTime, nullable=False)

    sector = relationship("Sector", back_populates="subsectors")
    deals = relationship("Deal", back_populates="subsector")
