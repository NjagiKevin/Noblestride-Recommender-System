from typing import Dict, List
from app.models.schemas import BusinessCreate, BusinessResponse, InvestorCreate, InvestorResponse
from app.services.embeddings import generate_embeddings, rebuild_vector_index, TextVectorizer

# In-memory storage for demo
businesses: Dict[str, BusinessCreate] = {}
investors: Dict[str, InvestorCreate] = {}
vectorizer = TextVectorizer()


def add_business(business: BusinessCreate) -> BusinessResponse:
    business_id = f"biz_{len(businesses)+1}"
    businesses[business_id] = business
    vectorizer.update_business(business_id, business)
    return BusinessResponse(id=business_id, **business.dict())

def add_investor(investor: InvestorCreate) -> InvestorResponse:
    investor_id = f"inv_{len(investors)+1}"
    investors[investor_id] = investor
    vectorizer.update_investor(investor_id, investor)
    return InvestorResponse(id=investor_id, **investor.dict())

def update_business(business_id: str, business: BusinessCreate) -> BusinessResponse:
    if business_id not in businesses:
        raise ValueError("Business not found")
    businesses[business_id] = business
    vectorizer.update_business(business_id, business)
    return BusinessResponse(id=business_id, **business.dict())

def update_investor(investor_id: str, investor: InvestorCreate) -> InvestorResponse:
    if investor_id not in investors:
        raise ValueError("Investor not found")
    investors[investor_id] = investor
    vectorizer.update_investor(investor_id, investor)
    return InvestorResponse(id=investor_id, **investor.dict())

def generate_rankings(investor_id: str, top_n: int = 5) -> List[dict]:
    if investor_id not in investors:
        raise ValueError("Investor not found")
    
    investor = investors[investor_id]
    scores = []
    
    for biz_id, business in businesses.items():
        # Simple matching logic (to be enhanced)
        industry_match = 1 if business.industry in investor.preferred_industries else 0
        description_sim = vectorizer.calculate_similarity(
            investor_id, 
            biz_id
        )
        score = (industry_match * 0.6) + (description_sim * 0.4)
        scores.append({"business_id": biz_id, "match_score": score})
    
    ranked = sorted(scores, key=lambda x: x["match_score"], reverse=True)
    return ranked[:top_n]