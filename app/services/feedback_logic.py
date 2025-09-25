# app/services/feedback_logic.py

from sqlalchemy.orm import Session
from app.models.schemas import FeedbackIn

from app.core.logging import logger

def process_feedback(feedback: str) -> dict:
    """
    Process feedback text (e.g., log it, analyze sentiment, etc.)
    Currently just logs and echoes.
    """
    logger.info(f"Processing feedback: {feedback}")
    return {"status": "received", "feedback": feedback}

def apply_feedback(feedback: FeedbackIn, db: Session):
    """
    Apply structured feedback from an investor about a business.
    Example: save to DB or update stats.
    """
    try:
        # Example: you might want to log or persist this into a 'feedback' table
        logger.info(
            f"Applying feedback: investor={feedback.investor_id}, "
            f"business={feedback.business_id}, type={feedback.event_type}"
        )

        # Here’s where you’d insert into a Feedback table (if you had one)
        # For now we just return a dict
        return {
            "message": "Feedback applied",
            "investor_id": feedback.investor_id,
            "business_id": feedback.business_id,
            "event_type": feedback.event_type,
        }

    except Exception as e:
        logger.error(f"Error applying feedback: {e}")
        raise
