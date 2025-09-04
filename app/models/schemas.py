from __future__ import annotations
from typing import List, Dict, Any, Optional
from pydantic import BaseModel, Field

# ---- Core domain objects ----
class BusinessBase(BaseModel):
    id: str
    legal_name: str
    sector: Optional[str] = None
    industry: Optional[str] = None
    location: Optional[str] = None
    sub_sector: Optional[str] = None
    countries: List[str] = Field(default_factory=list)
    region: Optional[str] = None
    stage: Optional[str] = None
    raise_min: Optional[float] = None
    raise_max: Optional[float] = None
    instruments: List[str] = Field(default_factory=list)
    impact_flags: List[str] = Field(default_factory=list)
    description: Optional[str] = None
    core_service: Optional[str] = None
    target_clients: List[str] = Field(default_factory=list)
    portfolio_keywords: List[str] = Field(default_factory=list)

    class Config:
        from_attributes = True   # important so FastAPI can return SQLAlchemy models

class BusinessCreate(BusinessBase):
    pass

class BusinessResponse(BusinessBase):
    pass


class InvestorBase(BaseModel):
    id: str
    fund_name: str
    sector_prefs: List[str] = Field(default_factory=list)
    stage_prefs: List[str] = Field(default_factory=list)
    countries_focus: List[str] = Field(default_factory=list)
    geo_regions: List[str] = Field(default_factory=list)
    countries_blocklist: List[str] = Field(default_factory=list)
    investment_range: Optional[str] = None
    ticket_min: Optional[float] = None
    ticket_max: Optional[float] = None
    instruments: List[str] = Field(default_factory=list)
    impact_flags: List[str] = Field(default_factory=list)
    mandate_text: Optional[str] = None
    track_record_text: Optional[str] = None
    timeline_hint: Optional[str] = None

    class Config:
        from_attributes = True

class InvestorCreate(InvestorBase):
    pass

class InvestorResponse(InvestorBase):
    pass


# ---- Feedback & ranking requests ----
class FeedbackIn(BaseModel):
    investor_id: str
    business_id: str
    event_type: str  # VDR_VIEW, NDA_SIGNED, EOI, MEETING, DECLINE, TERM_SHEET
    meta: Dict[str, Any] = Field(default_factory=dict)

class RankDealsRequest(BaseModel):
    top_k: int = 10

class RankInvestorsRequest(BaseModel):
    top_k: int = 10

# ---- Ranking ----
class RankedBusiness(BaseModel):
    reasons: List[str]
    business: BusinessResponse

class RankedInvestor(BaseModel):
    reasons: List[str]
    investor: InvestorResponse

class RankedBusinessResponse(BaseModel):
    items: List[RankedBusiness]

class RankedInvestorResponse(BaseModel):
    items: List[RankedInvestor]

class UpsertResponse(BaseModel):
    ok: bool
    count: int

class FeedbackCreate(BaseModel):
    investor_id: str
    business_id: str
    feedback_type: str
