from app.services.recommender import add_investor, add_business
from app.models.schemas import InvestorCreate, BusinessCreate

def seed_data():
    """
    Seeds the in-memory recommender service with a set of initial data.
    """
    print("--- Seeding initial data into recommender memory ---")

    # --- Investors ---
    investors_to_add = [
        InvestorCreate(
            id="inv_123",
            fund_name="Future Forward Ventures",
            sector_prefs=["SaaS", "FinTech"],
            stage_prefs=["Seed", "Series A"],
            countries_focus=["USA", "Canada"],
            geo_regions=["North America"],
            investment_range="500K-2M",
            ticket_min=500000,
            ticket_max=2000000,
            instruments=["Equity", "Convertible Note"],
            impact_flags=["B2B"],
            mandate_text="We back ambitious founders building the future of B2B software and financial technology."
        ),
        InvestorCreate(
            id="inv_201",
            fund_name="GreenGrowth Capital",
            sector_prefs=["CleanTech", "Sustainability", "Renewable Energy"],
            stage_prefs=["Series A", "Series B"],
            countries_focus=["USA", "Germany"],
            geo_regions=["North America", "Europe"],
            ticket_min=2000000,
            ticket_max=10000000,
            instruments=["Equity"],
            impact_flags=["ESG", "Climate Tech"],
            mandate_text="Investing in technologies that create a sustainable future for our planet."
        ),
        InvestorCreate(
            id="inv_202",
            fund_name="HealthWell Partners",
            sector_prefs=["HealthTech", "BioTech", "Digital Health"],
            stage_prefs=["Seed", "Series A"],
            countries_focus=["USA"],
            geo_regions=["North America"],
            ticket_min=500000,
            ticket_max=5000000,
            instruments=["Equity"],
            impact_flags=["Healthcare"],
            mandate_text="Dedicated to funding innovations that improve patient outcomes and healthcare efficiency."
        )
    ]

    for investor in investors_to_add:
        add_investor(investor)

    # --- Businesses ---
    businesses_to_add = [
        BusinessCreate(
            id="biz_456",
            legal_name="PayStream Solutions",
            sector="FinTech",
            industry="SaaS",
            location="New York",
            description="A SaaS platform that simplifies recurring payments for B2B companies.",
            stage="Series A",
            raise_min=1000000,
            raise_max=3000000,
            impact_flags=["B2B"]
        ),
        BusinessCreate(
            id="biz_301",
            legal_name="Solaris Innovations",
            sector="CleanTech",
            industry="Renewable Energy",
            location="Austin",
            description="Pioneering new solar panel technology that doubles energy efficiency.",
            stage="Series A",
            raise_min=3000000,
            raise_max=8000000,
            impact_flags=["Climate Tech", "ESG"]
        ),
        BusinessCreate(
            id="biz_302",
            legal_name="Medica Analytics",
            sector="HealthTech",
            industry="Digital Health",
            location="Boston",
            description="An AI-powered platform for analyzing medical data to predict disease outbreaks.",
            stage="Seed",
            raise_min=1000000,
            raise_max=4000000,
            impact_flags=["Healthcare", "AI"]
        )
    ]

    for business in businesses_to_add:
        add_business(business)

    print(f"--- Seeding complete: {len(investors_to_add)} investors, {len(businesses_to_add)} businesses ---")
