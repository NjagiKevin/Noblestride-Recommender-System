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

vectorizer = TextVectorizer()

def recommend_deals_for_user(db: Session, user_id: int, top_n: int = 10) -> List[dict]:
    logging.basicConfig(level=logging.INFO)
    investor = db.query(User).filter(User.id == user_id, User.role == 'Investor').first()
    if not investor:
        logging.warning(f"Investor with id {user_id} not found.")
        raise ValueError("Investor not found")

    logging.info(f"Investor found: {investor.name} with preferences: {investor.preference_sector}")

    all_deals = (
        db.query(Deal)
        .options(joinedload(Deal.sector), joinedload(Deal.subsector))
        .filter(Deal.status == 'Active')
        .all()
    )
    logging.info(f"Found {len(all_deals)} active deals.")
    if not all_deals:
        return []

    investor_text = f"{investor.name} {investor.description or ''}"
    investor_embedding = vectorizer.vectorize_text(investor_text)

    scores = []
    for deal in all_deals:
        reasons = []
        sector_name = deal.sector.name if deal.sector else ''
        subsector_name = deal.subsector.name if deal.subsector else ''
        deal_text = f"{deal.title or ''} {deal.description or ''} {sector_name} {subsector_name}"
        deal_embedding = vectorizer.vectorize_text(deal_text)

        # Match investor's preferred sector
        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity([investor_embedding], [deal_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (1 if reasons else 0)
        logging.info(f"Deal: {deal.title}, Score: {score}, Reasons: {reasons}")

        if score > 0.5:
            scores.append({
                "deal_id": str(deal.deal_id),
                "title": deal.title,
                "description": deal.description,
                "sector": sector_name,
                "subsector": subsector_name,
                "score": score,
                "reasons": reasons
            })

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


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
    deal_embedding = vectorizer.vectorize_text(deal_text)

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name} {investor.description or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text)

        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Invests in your sector: {sector_name}")

        description_sim = cosine_similarity([deal_embedding], [investor_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on your company description.")

        score = description_sim + (1 if reasons else 0)

        if score > 0.5:
            scores.append({
                "user_id": investor.id,
                "name": investor.name,
                "email": investor.email,
                "description": investor.description,
                "location": investor.location,
                "preference_sector": investor.preference_sector,
                "score": score,
                "reasons": reasons
            })

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]


def recommend_investors_for_business(db: Session, business: BusinessCreate, top_n: int = 10) -> List[dict]:
    sector_name, subsector_name = "", ""

    if business.sector_id:
        sector = db.query(Sector).filter(Sector.sector_id == business.sector_id).first()
        if sector:
            sector_name = sector.name

    if business.subsector_id:
        subsector = db.query(Subsector).filter(Subsector.subsector_id == business.subsector_id).first()
        if subsector:
            subsector_name = subsector.name

    business_text = f"{business.legal_name} {business.description or ''} {sector_name} {subsector_name}"
    business_embedding = vectorizer.vectorize_text(business_text)

    all_investors = db.query(User).filter(User.role == 'Investor').all()
    if not all_investors:
        return []

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name} {investor.description or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text)

        if investor.preference_sector and sector_name and sector_name in (investor.preference_sector or []):
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity([business_embedding], [investor_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (1 if reasons else 0)

        if score > 0.5:
            scores.append({
                "user_id": investor.id,
                "score": score,
                "reasons": reasons
            })

    return sorted(scores, key=lambda x: x["score"], reverse=True)[:top_n]

def recommend_investors_endpoint(deal_id: UUID, db: Session = Depends(get_db)):
    return recommend_investors_for_deal(db, deal_id)
