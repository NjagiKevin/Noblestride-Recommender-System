from __future__ import annotations
from typing import List, Optional, Dict, Any
from pydantic import BaseModel, Field
import uuid
from datetime import datetime

# ---- Role Schema ----
class RoleSchema(BaseModel):
    role_id: uuid.UUID
    name: str
    class Config:
        from_attributes = True

# ---- Sector Schemas ----
class SectorSchema(BaseModel):
    sector_id: uuid.UUID
    name: str
    class Config:
        from_attributes = True

class SubsectorSchema(BaseModel):
    subsector_id: uuid.UUID
    name: str
    class Config:
        from_attributes = True

# ---- User Schemas ----
class UserBase(BaseModel):
    email: str
    name: str
    description: Optional[str] = None
    location: Optional[str] = None
    role: str = 'Investor'
    preference_sector: Optional[List[str]] = None

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: int
    profile_image: Optional[str] = None
    createdAt: datetime
    updatedAt: datetime
    role_id: uuid.UUID # This is now in UserResponse, not UserBase
    role_obj: RoleSchema

    class Config:
        from_attributes = True

class UserUpdate(BaseModel):
    email: Optional[str] = None
    name: Optional[str] = None
    description: Optional[str] = None
    location: Optional[str] = None
    preference_sector: Optional[List[str]] = None
    profile_image: Optional[str] = None
    password: Optional[str] = None

    class Config:
        from_attributes = True


# ---- Deal Schemas ----
class DealBase(BaseModel):
    title: str
    description: str
    deal_size: float
    deal_type: Optional[str] = None

class DealCreate(DealBase):
    created_by: int
    target_company_id: int  # <- comment moved to the side properly
    sector_id: uuid.UUID
    subsector_id: Optional[uuid.UUID] = None

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

# ---- Ranking Schemas ----
class RankedDeal(BaseModel):
    reasons: List[str]
    deal: DealResponse

class RankedUser(BaseModel):
    reasons: List[str]
    user: UserResponse

class RankedDealResponse(BaseModel):
    items: List[RankedDeal]

class RankedUserResponse(BaseModel):
    items: List[RankedUser]

# ---- Request Schemas for Ranking ----
class RankDealsRequest(BaseModel):
    top_k: int = 10

class RankInvestorsRequest(BaseModel):
    top_k: int = 10

# ---- Feedback & Other Schemas ----
class FeedbackIn(BaseModel):
    investor_id: str
    business_id: str
    event_type: str
    meta: Dict[str, Any] = Field(default_factory=dict)

class UpsertResponse(BaseModel):
    ok: bool
    count: int

class FeedbackCreate(BaseModel):
    investor_id: str
    business_id: str
    feedback_type: str

# ---- Business Schemas ----
class BusinessBase(BaseModel):
    id: str
    legal_name: str
    description: Optional[str] = None
    location: Optional[str] = None
    sector_id: Optional[uuid.UUID] = None
    subsector_id: Optional[uuid.UUID] = None
    capital_needed: Optional[float] = None

class BusinessCreate(BusinessBase):
    pass

class BusinessResponse(BusinessBase):
    createdAt: datetime
    updatedAt: datetime

    class Config:
        from_attributes = True

# ---- Investor Schemas ----
class InvestorBase(BaseModel):
    name: str
    email: str
    description: Optional[str] = None
    location: Optional[str] = None
    preference_sector: Optional[List[str]] = None

class InvestorCreate(InvestorBase):
    id: int

class InvestorResponse(InvestorBase):
    id: int
    reasons: List[str]

    class Config:
        from_attributes = True