from __future__ import annotations
from typing import List, Optional
from pydantic import BaseModel, Field
import uuid
from datetime import datetime

# ---- User Schemas ----
class UserBase(BaseModel):
    email: str
    name: str
    description: Optional[str] = None
    location: Optional[str] = None
    role: str = 'Investor'

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: int
    profile_image: Optional[str] = None
    createdAt: datetime
    updatedAt: datetime

    class Config:
        from_attributes = True

# ---- Deal Schemas ----
class DealBase(BaseModel):
    title: str
    description: str
    deal_size: float
    sector: Optional[str] = None
    subsector: Optional[str] = None
    deal_type: Optional[str] = None

class DealCreate(DealBase):
    created_by: int

class DealResponse(DealBase):
    deal_id: uuid.UUID
    project: Optional[str] = None
    image_url: Optional[str] = None
    status: str
    visibility: str
    createdAt: datetime
    updatedAt: datetime
    created_by_user: UserResponse

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