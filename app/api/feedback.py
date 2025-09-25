# app/api/feedback.py
from fastapi import APIRouter, Body
from app.models.schemas import FeedbackIn


router = APIRouter()

@router.post("/")
def submit_feedback(feedback_data: dict = Body(...)):
    # Logic to store feedback
    print(f"Received feedback: {feedback_data}")
    return {"status": "feedback received"}