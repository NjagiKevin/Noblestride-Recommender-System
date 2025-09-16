from typing import List
from uuid import UUID
import numpy as np
from sqlalchemy.orm import Session, joinedload
from sklearn.metrics.pairwise import cosine_similarity
from fastapi import Depends
from app.db.session import get_db
import logging

from app.models.db_models import User, Deal, Sector, Subsector
from app.models.schemas import BusinessCreate
from app.services.embeddings import TextVectorizer

# Initialize vectorizer
vectorizer = TextVectorizer()
logger = logging.getLogger(__name__)


# -------------------------
# Investor → Deals
# -------------------------
def recommend_deals_for_user(db: Session, user_id: int, top_n: int = 10) -> List[dict]:
    investor = db.query(User).filter(User.id == user_id, User.role == 'Investor').first()
    if not investor:
        raise ValueError(f"Investor with id {user_id} not found")

    all_deals = (
        db.query(Deal)
        .options(
            joinedload(Deal.sector),
            joinedload(Deal.subsector),
            joinedload(Deal.target_company),   # links to business user
        )
        .filter(Deal.status == 'Active')
        .all()
    )
    if not all_deals:
        return []

    investor_text = f"{investor.name or ''} {investor.description or ''}"
    investor_embedding = vectorizer.vectorize_text(investor_text).reshape(1, -1)

    scores = []
    for deal in all_deals:
        reasons = []
        sector_name = deal.sector.name if deal.sector else ''
        subsector_name = deal.subsector.name if deal.subsector else ''
        deal_text = f"{deal.title or ''} {deal.description or ''} {sector_name} {subsector_name}"
        deal_embedding = vectorizer.vectorize_text(deal_text).reshape(1, -1)

        # Match sector preferences
        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity(investor_embedding, deal_embedding)[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (0.2 if reasons else 0)

        if score > 0.5:
            scores.append({
                "deal_id": str(deal.deal_id),
                "title": deal.title,
                "description": deal.description,
                "sector": sector_name,
                "subsector": subsector_name,
                "score": round(float(score), 3),
                "reasons": reasons,
                "business": {
                    "id": deal.target_company.id if deal.target_company else None,
                    "legal_name": deal.target_company.name if deal.target_company else None,
                    "email": deal.target_company.email if deal.target_company else None,
                    "location": deal.target_company.location if deal.target_company else None,
                }
            })

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


# -------------------------
# Deal → Investors
# -------------------------
def recommend_investors_for_deal(db: Session, deal_id: UUID, top_n: int = 10) -> List[dict]:
    deal = (
        db.query(Deal)
        .options(joinedload(Deal.sector), joinedload(Deal.subsector))
        .filter(Deal.deal_id == deal_id)
        .first()
    )
    if not deal:
        raise ValueError("Deal not found")

    all_investors = db.query(User).filter(User.role == 'Investor').all()
    if not all_investors:
        return []

    sector_name = deal.sector.name if deal.sector else ''
    subsector_name = deal.subsector.name if deal.subsector else ''
    deal_text = f"{deal.title or ''} {deal.description or ''} {sector_name} {subsector_name}"
    deal_embedding = vectorizer.vectorize_text(deal_text).reshape(1, -1)

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name or ''} {investor.description or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text).reshape(1, -1)

        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Invests in your sector: {sector_name}")

        description_sim = cosine_similarity(deal_embedding, investor_embedding)[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on your company description.")

        score = description_sim + (0.2 if reasons else 0)

        if score > 0.5:
            scores.append({
                "user_id": investor.id,
                "name": investor.name,
                "email": investor.email,
                "description": investor.description,
                "location": investor.location,
                "preference_sector": investor.preference_sector,
                "score": round(float(score), 3),
                "reasons": reasons
            })

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


# -------------------------
# Business → Investors
# -------------------------
def recommend_investors_for_business(db: Session, business: BusinessCreate, top_n: int = 10) -> List[dict]:
    sector_name = business.sector or ""
    subsector_name = business.sub_sector or ""

    business_text = f"{business.legal_name or ''} {business.description or ''} {sector_name} {subsector_name}"
    business_embedding = vectorizer.vectorize_text(business_text).reshape(1, -1)

    all_investors = db.query(User).filter(User.role == 'Investor').all()
    if not all_investors:
        return []

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name or ''} {investor.description or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text).reshape(1, -1)

        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity(business_embedding, investor_embedding)[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (0.2 if reasons else 0)

        if score > 0.5:
            scores.append({
                "user_id": investor.id,
                "name": investor.name,
                "email": investor.email,
                "location": investor.location,
                "score": round(float(score), 3),
                "reasons": reasons
            })

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


# Convenience wrapper for FastAPI
def recommend_investors_endpoint(deal_id: UUID, db: Session = Depends(get_db)):
    return recommend_investors_for_deal(db, deal_id)