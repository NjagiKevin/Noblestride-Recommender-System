from fastapi import APIRouter, BackgroundTasks, HTTPException
from app.services.embeddings import rebuild_vector_index
import logging

router = APIRouter(prefix="/embeddings", tags=["embeddings"])
logger = logging.getLogger(__name__)

@router.get("/status")
def status():
    try:
        from app.services.embeddings import get_embeddings_status
        return get_embeddings_status()
    except Exception as e:
        logger.error(f"Failed to get embeddings status: {e}")
        raise HTTPException(status_code=500, detail="Failed to get embeddings status")

@router.get("/dimension")
def dimension():
    try:
        from app.services.embeddings import text_vectorizer
        # do not force load; if not loaded, dimension may be None
        st = text_vectorizer.status()
        if not st.get("loaded"):
            # Lazily load only to serve dimension
            try:
                _ = text_vectorizer.get_embedding_dimension()
                st = text_vectorizer.status()
            except Exception:
                pass
        return {"dimension": st.get("dimension"), "loaded": st.get("loaded")}
    except Exception as e:
        logger.error(f"Failed to get embeddings dimension: {e}")
        raise HTTPException(status_code=500, detail="Failed to get embeddings dimension")

@router.post("/rebuild")
def rebuild(background_tasks: BackgroundTasks):
    """Trigger a background rebuild of the vector index from the DB."""
    try:
        background_tasks.add_task(rebuild_vector_index)
        return {"status": "accepted", "message": "Embeddings rebuild started"}
    except Exception as e:
        logger.error(f"Failed to trigger embeddings rebuild: {e}")
        raise HTTPException(status_code=500, detail="Failed to trigger embeddings rebuild")