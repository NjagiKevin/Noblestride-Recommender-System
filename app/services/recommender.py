from typing import Dict, List
from app.models.schemas import BusinessCreate, BusinessResponse, InvestorCreate, InvestorResponse
from app.services.embeddings import TextVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

# In-memory storage for demo
businesses: Dict[str, BusinessCreate] = {}
investors: Dict[str, InvestorCreate] = {}
vectorizer = TextVectorizer()


def add_business(business: BusinessCreate):
    businesses[business.id] = business


def add_investor(investor: InvestorCreate):
    investors[investor.id] = investor


def update_business(business_id: str, business: BusinessCreate):
    if business_id not in businesses:
        raise ValueError("Business not found")
    businesses[business_id] = business


def update_investor(investor_id: str, investor: InvestorCreate):
    if investor_id not in investors:
        raise ValueError("Investor not found")
    investors[investor_id] = investor


def generate_rankings(investor_id: str, top_n: int = 5) -> List[dict]:
    print(f"--- Generating recommendations for investor: {investor_id} ---")
    print(f"Current investors in memory: {list(investors.keys())}")
    print(f"Current businesses in memory: {list(businesses.keys())}")

    if investor_id not in investors:
        raise ValueError("Investor not found")

    investor = investors[investor_id]
    investor_text = f"{investor.fund_name} {' '.join(investor.sector_prefs)} {investor.mandate_text or ''}"
    investor_embedding = vectorizer.vectorize_text(investor_text)

    scores = []

    for biz_id, business in businesses.items():
        business_text = f"{business.legal_name} {business.sector} {business.location} {business.description or ''}"
        business_embedding = vectorizer.vectorize_text(business_text)
        
        industry_match = 1 if business.industry in investor.sector_prefs else 0
        
        description_sim = cosine_similarity([investor_embedding], [business_embedding])[0][0]
        
        score = (industry_match * 0.6) + (description_sim * 0.4)
        
        print(f"  - Business: {biz_id}, Industry Match: {industry_match}, Similarity: {description_sim:.4f}, Final Score: {score:.4f}")
        
        scores.append({"business_id": biz_id, "match_score": score})

    ranked = sorted(scores, key=lambda x: x["match_score"], reverse=True)
    
    print(f"--- Ranking complete. Found {len(ranked)} potential matches. ---")
    
    return ranked[:top_n]


def recommend_investors_for_business(business: BusinessCreate, top_n: int = 5) -> List[dict]:
    business_text = f"{business.legal_name} {business.sector} {business.location} {business.description or ''}"
    business_embedding = vectorizer.vectorize_text(business_text)
    
    scores = []

    for inv_id, investor in investors.items():
        investor_text = f"{investor.fund_name} {' '.join(investor.sector_prefs)} {investor.mandate_text or ''}"
        investor_embedding = vectorizer.vectorize_text(investor_text)

        industry_match = 1 if business.industry in investor.sector_prefs else 0
        
        description_sim = cosine_similarity([business_embedding], [investor_embedding])[0][0]
        
        score = (industry_match * 0.6) + (description_sim * 0.4)
        scores.append({"investor_id": inv_id, "match_score": score})

    ranked = sorted(scores, key=lambda x: x["match_score"], reverse=True)
    return ranked[:top_n]