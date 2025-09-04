from typing import List
import uuid
from sqlalchemy.orm import Session, joinedload
from app.models.db_models import User, Deal
from app.services.embeddings import TextVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

vectorizer = TextVectorizer()

def recommend_deals_for_user(db: Session, user_id: int, top_n: int = 10) -> List[dict]:
    """
    Recommends deals for a given user (investor).
    """
    investor = db.query(User).filter(User.id == user_id, User.role == 'Investor').first()
    if not investor:
        raise ValueError("Investor not found")

    all_deals = db.query(Deal).options(joinedload(Deal.sector), joinedload(Deal.subsector)).filter(Deal.status == 'Active').all()
    if not all_deals:
        return []

    investor_text = f"{investor.name} {investor.description or ''}"
    investor_embedding = vectorizer.vectorize_text(investor_text)

    scores = []
    for deal in all_deals:
        reasons = []
        sector_name = deal.sector.name if deal.sector else ''
        subsector_name = deal.subsector.name if deal.subsector else ''
        deal_text = f"{deal.title} {deal.description} {sector_name} {subsector_name}"
        deal_embedding = vectorizer.vectorize_text(deal_text)

        # Matching logic using preference_sector
        if investor.preference_sector and sector_name and sector_name in investor.preference_sector:
            reasons.append(f"Matches preferred sector: {sector_name}")

        description_sim = cosine_similarity([investor_embedding], [deal_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description.")

        score = description_sim + (1 if reasons else 0)

        if score > 0.5:
            scores.append({"deal_id": deal.deal_id, "score": score, "reasons": reasons})

    ranked = sorted(scores, key=lambda x: x["score"], reverse=True)
    return ranked[:top_n]


def recommend_investors_for_deal(db: Session, deal_id: uuid.UUID, top_n: int = 10) -> List[dict]:
    """
    Recommends investors for a given deal.
    """
    deal = db.query(Deal).options(joinedload(Deal.sector), joinedload(Deal.subsector)).filter(Deal.deal_id == deal_id).first()
    if not deal:
        raise ValueError("Deal not found")

    all_investors = db.query(User).filter(User.role == 'Investor').all()
    if not all_investors:
        return []

    sector_name = deal.sector.name if deal.sector else ''
    subsector_name = deal.subsector.name if deal.subsector else ''
    deal_text = f"{deal.title} {deal.description} {sector_name} {subsector_name}"
    deal_embedding = vectorizer.vectorize_text(deal_text)

    scores = []
    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.name} {investor.description or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text)

        if investor.preference_sector and sector_name and sector_name in investor.preference_sector:
            reasons.append(f"Invests in your sector: {sector_name}")

        description_sim = cosine_similarity([deal_embedding], [investor_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on your company description.")

        score = description_sim + (1 if reasons else 0)

        if score > 0.5:
            scores.append({"user_id": investor.id, "score": score, "reasons": reasons})

    ranked = sorted(scores, key=lambda x: x["score"], reverse=True)
    return ranked[:top_n]
