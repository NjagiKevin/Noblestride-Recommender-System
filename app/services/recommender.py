from typing import List
from uuid import UUID
import numpy as np
from sqlalchemy.orm import Session, joinedload
from sklearn.metrics.pairwise import cosine_similarity
from fastapi import Depends
from app.db.session import get_db
import logging

from app.models.db_models import User, Business,Deal, Sector, Subsector
from app.models.schemas import BusinessCreate
from app.services.embeddings import TextVectorizer

# Initialize vectorizer
vectorizer = TextVectorizer()
logger = logging.getLogger(__name__)


# -------------------------
# Investor → Deals
# -------------------------
def recommend_deals_for_user(db: Session, user_id: int, top_n: int = 10) -> List[Deal]:
    logger.info(f"Recommending deals for user_id: {user_id}")
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
    logger.info(f"Found {len(all_deals)} active deals.")
    if not all_deals:
        return []

    investor_text = f"{investor.name or ''} {investor.description or ''}"
    investor_embedding = np.array(vectorizer.vectorize_text(investor_text)).reshape(1, -1)

    scores = []
    for deal in all_deals:
        reasons = []
        sector_name = deal.sector.name if deal.sector else ''
        subsector_name = deal.subsector.name if deal.subsector else ''
        deal_text = f"{deal.title or ''} {deal.description or ''} {sector_name} {subsector_name}"
        deal_embedding = np.array(vectorizer.vectorize_text(deal_text)).reshape(1, -1)

        # Match sector preferences
        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity(investor_embedding, deal_embedding)[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (0.2 if reasons else 0)

        if score > 0.5:
            scores.append((deal, score, reasons))

    # ✅ Fallback Mode: return recent deals if no match
    if not scores:
        logger.info("No matching deals found, using fallback.")
        return (
            db.query(Deal)
            .options(
                joinedload(Deal.sector),
                joinedload(Deal.subsector),
                joinedload(Deal.target_company),
            )
            .filter(Deal.status == 'Active')
            .order_by(Deal.createdAt.desc())
            .limit(top_n)
            .all()
        )

    scores.sort(key=lambda x: x[1], reverse=True)

    return [deal for deal, score, reasons in scores[:top_n]]


# -------------------------
# Investor → Businesses
# -------------------------
def recommend_businesses_for_investor(db: Session, user_id: int, top_n: int = 10) -> List[Business]:
    investor = db.query(User).filter(User.id == user_id, User.role == 'Investor').first()
    if not investor:
        raise ValueError(f"Investor with id {user_id} not found")

    all_businesses = (
        db.query(Business)
        .options(
            joinedload(Business.sector_rel), # Assuming Business has a relationship to Sector
            joinedload(Business.subsector_rel), # Assuming Business has a relationship to Subsector
        )
        .all()
    )
    if not all_businesses:
        return []

    investor_text = f"{investor.name or ''} {investor.description or ''}"
    investor_embedding = np.array(vectorizer.vectorize_text(investor_text)).reshape(1, -1)

    scores = []
    for business in all_businesses:
        reasons = []
        sector_name = business.sector_rel.name if business.sector_rel else ''
        subsector_name = business.subsector_rel.name if business.subsector_rel else ''
        business_text = f"{business.legal_name or ''} {business.description or ''} {sector_name} {subsector_name}"
        business_embedding = np.array(vectorizer.vectorize_text(business_text)).reshape(1, -1)

        # Match sector preferences
        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity(investor_embedding, business_embedding)[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (0.2 if reasons else 0)

        if score > 0.5:
            scores.append((business, score, reasons))

    # ✅ Fallback Mode: return recent businesses if no match
    if not scores:
        return (
            db.query(Business)
            .order_by(Business.createdAt.desc())
            .limit(top_n)
            .all()
        )

    scores.sort(key=lambda x: x[1], reverse=True)
    
    return [business for business, score, reasons in scores[:top_n]]


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
    deal_embedding = np.array(vectorizer.vectorize_text(deal_text)).reshape(1, -1)

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name or ''} {investor.description or ''}"
        investor_embedding = np.array(vectorizer.vectorize_text(investor_text)).reshape(1, -1)

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

    # ✅ Fallback Mode: return recent investors if no match
    if not scores:
        fallback = (
            db.query(User)
            .filter(User.role == 'Investor')
            .order_by(User.createdAt.desc())
            .limit(top_n)
            .all()
        )
        return [
            {
                "user_id": inv.id,
                "name": inv.name,
                "email": inv.email,
                "description": inv.description,
                "location": inv.location,
                "preference_sector": inv.preference_sector,
                "score": 0.0,
                "reasons": ["Fallback suggestion: No strong sector/description match"]
            }
            for inv in fallback
        ]

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


# -------------------------
# Business → Investors
# -------------------------
def recommend_investors_for_business(db: Session, business: BusinessCreate, top_n: int = 10) -> List[dict]:
    sector_name = business.sector or ""
    subsector_name = business.sub_sector or ""

    business_text = f"{business.legal_name or ''} {business.description or ''} {sector_name} {subsector_name}"
    business_embedding = np.array(vectorizer.vectorize_text(business_text)).reshape(1, -1)

    all_investors = db.query(User).filter(User.role == 'Investor').all()
    if not all_investors:
        return []

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name or ''} {investor.description or ''}"
        investor_embedding = np.array(vectorizer.vectorize_text(investor_text)).reshape(1, -1)

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

    # ✅ Fallback Mode: return recent investors if no match
    if not scores:
        fallback = (
            db.query(User)
            .filter(User.role == 'Investor')
            .order_by(User.createdAt.desc())
            .limit(top_n)
            .all()
        )
        return [
            {
                "user_id": inv.id,
                "name": inv.name,
                "email": inv.email,
                "location": inv.location,
                "score": 0.0,
                "reasons": ["Fallback suggestion: No strong sector/description match"]
            }
            for inv in fallback
        ]

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


# Convenience wrapper for FastAPI
def recommend_investors_endpoint(deal_id: UUID, db: Session = Depends(get_db)):
    return recommend_investors_for_deal(db, deal_id)