import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.db.session import get_db
from unittest.mock import MagicMock

@pytest.fixture
def client():
    # Mock the database dependency
    def override_get_db():
        db = MagicMock()
        yield db

    app.dependency_overrides[get_db] = override_get_db
    yield TestClient(app)
    app.dependency_overrides.clear()

def test_get_deal_recommendations_for_user(client):
    response = client.post("/rank/users/1/recommended-deals", json={"top_k": 5})
    assert response.status_code == 200

def test_get_investor_recommendations_for_deal(client):
    response = client.post("/rank/deals/1/recommended-investors", json={"top_k": 5})
    assert response.status_code == 200
