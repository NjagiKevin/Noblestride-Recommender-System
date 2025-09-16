from __future__ import annotations
from typing import List, Optional, Dict, Any
from pydantic import BaseModel, Field
import uuid
from datetime import datetime


# ---- Base Schemas ----
class BusinessBase(BaseModel):
    id: Optional[uuid.UUID] = None
    legal_name: Optional[str] = None
    sector: Optional[str] = None
    industry: Optional[str] = None
    location: Optional[str] = None
    sub_sector: Optional[str] = None
    countries: Optional[list] = None
    region: Optional[str] = None
    stage: Optional[str] = None
    raise_min: Optional[float] = None
    raise_max: Optional[float] = None
    instruments: Optional[list] = None
    impact_flags: Optional[list] = None
    description: Optional[str] = None
    core_service: Optional[str] = None
    target_clients: Optional[list] = None
    portfolio_keywords: Optional[list] = None
    capital_needed: Optional[float] = None
    createdAt: datetime
    updatedAt: datetime

    class Config:
        orm_mode = True


class DealBase(BaseModel):
    title: str
    description: str
    deal_size: float
    deal_type: Optional[str] = None


class RoleSchema(BaseModel):
    role_id: uuid.UUID
    name: str

    class Config:
        from_attributes = True


class SectorSchema(BaseModel):
    sector_id: uuid.UUID
    name: str

    class Config:
        from_attributes = True


class SubsectorSchema(BaseModel):
    subsector_id: uuid.UUID
    name: str
    sector_id: uuid.UUID

    class Config:
        from_attributes = True


class SubsectorCreate(BaseModel):
    name: str
    sector_id: uuid.UUID


class UserBase(BaseModel):
    email: str
    name: str
    description: Optional[str] = None
    location: Optional[str] = None
    role: str = "Investor"
    preference_sector: Optional[List[str]] = None
    preference_region: Optional[List[str]] = None
    total_investments: Optional[int] = None
    average_check_size: Optional[float] = None
    successful_exits: Optional[int] = None
    portfolio_ipr: Optional[float] = None
    addressable_market: Optional[str] = None
    current_market: Optional[str] = None
    total_assets: Optional[str] = None
    ebitda: Optional[str] = None
    gross_margin: Optional[str] = None
    cac_payback_period: Optional[str] = None
    tam: Optional[str] = None
    sam: Optional[str] = None
    som: Optional[str] = None
    year_founded: Optional[str] = None
    phone: Optional[str] = None


# ---- Create Schemas ----
class BusinessCreate(BusinessBase):
    capital_needed: Optional[float] = None


class DealCreate(DealBase):
    created_by: int
    target_company_id: int
    sector_id: uuid.UUID
    subsector_id: Optional[uuid.UUID] = None


class FeedbackCreate(BaseModel):
    investor_id: str
    business_id: str
    feedback_type: str


class UserCreate(UserBase):
    password: str


# ---- Update Schemas ----
class DealStatusUpdate(BaseModel):
    status: str


class UserUpdate(BaseModel):
    email: Optional[str] = None
    name: Optional[str] = None
    description: Optional[str] = None
    location: Optional[str] = None
    preference_sector: Optional[List[str]] = None
    preference_region: Optional[List[str]] = None
    profile_image: Optional[str] = None
    password: Optional[str] = None
    total_investments: Optional[int] = None
    average_check_size: Optional[float] = None
    successful_exits: Optional[int] = None
    portfolio_ipr: Optional[float] = None
    addressable_market: Optional[str] = None
    current_market: Optional[str] = None
    total_assets: Optional[str] = None
    ebitda: Optional[str] = None
    gross_margin: Optional[str] = None
    cac_payback_period: Optional[str] = None
    tam: Optional[str] = None
    sam: Optional[str] = None
    som: Optional[str] = None
    year_founded: Optional[str] = None
    phone: Optional[str] = None

    class Config:
        from_attributes = True


# ---- Response Schemas ----
class BusinessResponse(BusinessBase):
    id: str
    legal_name: Optional[str]
    description: Optional[str]
    location: Optional[str]
    capital_needed: Optional[float]

    class Config:
        orm_mode = True


class DealResponse(DealBase):
    deal_id: uuid.UUID
    project: Optional[str] = None
    status: str
    visibility: str
    createdAt: datetime
    updatedAt: datetime
    created_by_user: UserResponse
    target_company: UserResponse
    sector: Optional[SectorSchema] = None
    subsector: Optional[SubsectorSchema] = None

    class Config:
        from_attributes = True


class RankedDeal(BaseModel):
    reasons: List[str]
    deal: DealResponse
    business: Optional[BusinessResponse] = None


class RankedUser(BaseModel):
    reasons: List[str]
    user: UserResponse


class RankedDealResponse(BaseModel):
    items: List[RankedDeal]


class RankedUserResponse(BaseModel):
    items: List[RankedUser]


class UserResponse(UserBase):
    id: int
    profile_image: Optional[str] = None
    createdAt: datetime
    updatedAt: datetime
    role_id: uuid.UUID
    role_obj: RoleSchema

    class Config:
        from_attributes = True


# ---- Other Schemas ----
class FeedbackIn(BaseModel):
    investor_id: str
    business_id: str
    event_type: str
    meta: Dict[str, Any] = Field(default_factory=dict)


class UpsertResponse(BaseModel):
    ok: bool
    count: int


# ---- Request Schemas for Ranking ----
class RankDealsRequest(BaseModel):
    top_k: int = 10


class RankInvestorsRequest(BaseModel):
    top_k: int = 10