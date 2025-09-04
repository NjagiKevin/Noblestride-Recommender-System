from typing import List
from sqlalchemy.orm import Session
from app.models.schemas import BusinessCreate, InvestorCreate
from app.models.db_models import Investor, Business
from app.services.embeddings import TextVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

vectorizer = TextVectorizer()

def generate_rankings(db: Session, investor_id: str, top_n: int = 5) -> List[dict]:
    investor = db.query(Investor).filter(Investor.id == investor_id).first()
    if not investor:
        raise ValueError("Investor not found")

    all_businesses = db.query(Business).all()
    if not all_businesses:
        return []

    investor_text = f"{investor.fund_name} {' '.join(investor.sector_prefs)} {investor.mandate_text or ''}"
    investor_embedding = vectorizer.vectorize_text(investor_text)

    scores = []

    for business in all_businesses:
        reasons = []
        business_text = f"{business.legal_name} {business.sector} {business.location} {business.description or ''}"
        business_embedding = vectorizer.vectorize_text(business_text)
        
        industry_match = 1 if business.industry in investor.sector_prefs else 0
        if industry_match:
            reasons.append(f"Matches preferred industry: {business.industry}")
        
        description_sim = cosine_similarity([investor_embedding], [business_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on description and mandate.")
        
        score = (industry_match * 0.6) + (description_sim * 0.4)
        
        if score > 0.5: # Only include recommendations with a minimum score
            scores.append({"business_id": business.id, "score": score, "reasons": reasons})

    ranked = sorted(scores, key=lambda x: x["score"], reverse=True)
    
    return ranked[:top_n]

def recommend_investors_for_business(db: Session, business_id: str, top_n: int = 5) -> List[dict]:
    business = db.query(Business).filter(Business.id == business_id).first()
    if not business:
        raise ValueError("Business not found")

    all_investors = db.query(Investor).all()
    if not all_investors:
        return []

    business_text = f"{business.legal_name} {business.sector} {business.location} {business.description or ''}"
    business_embedding = vectorizer.vectorize_text(business_text)
    
    scores = []

    for investor in all_investors:
        reasons = []
        investor_text = f"{investor.fund_name} {' '.join(investor.sector_prefs)} {investor.mandate_text or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text)

        industry_match = 1 if business.industry in investor.sector_prefs else 0
        if industry_match:
            reasons.append(f"Invests in your industry: {business.industry}")
        
        description_sim = cosine_similarity([business_embedding], [investor_embedding])[0][0]
        if description_sim > 0.5:
            reasons.append("Similar focus based on your company description.")
        
        score = (industry_match * 0.6) + (description_sim * 0.4)
        
        if score > 0.5: # Only include recommendations with a minimum score
            scores.append({"investor_id": investor.id, "score": score, "reasons": reasons})

    ranked = sorted(scores, key=lambda x: x["score"], reverse=True)
    
    return ranked[:top_n]