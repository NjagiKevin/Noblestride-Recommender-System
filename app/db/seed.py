from app.services import recommender
from app.models.schemas import BusinessCreate, InvestorCreate

def seed_sample_data():
    # Sample businesses
    businesses = [
        BusinessCreate(
            name="EcoTech Solutions",
            description="Green technology for urban environments",
            industry="CleanTech",
            location="San Francisco",
            funding_needed=500000
        ),
        BusinessCreate(
            name="HealthAI",
            description="AI-powered healthcare diagnostics",
            industry="HealthTech",
            location="Boston",
            funding_needed=1200000
        )
    ]
    
    # Sample investors
    investors = [
        InvestorCreate(
            name="Green Ventures",
            preferred_industries=["CleanTech", "AgTech"],
            investment_range="500K-2M",
            risk_tolerance="Medium"
        ),
        InvestorCreate(
            name="TechGrowth Capital",
            preferred_industries=["HealthTech", "FinTech"],
            investment_range="1M-5M",
            risk_tolerance="High"
        )
    ]
    
    # Add to system
    for biz in businesses:
        recommender.add_business(biz)
    
    for inv in investors:
        recommender.add_investor(inv)
    
    return {"status": "seeded", "businesses": len(businesses), "investors": len(investors)}