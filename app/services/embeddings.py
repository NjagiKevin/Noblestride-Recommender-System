from typing import Dict, List, Any
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
from app.db.session import SessionLocal
from app.core.logging import logger

class TextVectorizer:
    def __init__(self, model_name: str = 'all-MiniLM-L6-v2', device: str = 'cpu'):
        """
        Initialize the text vectorizer with lazy model loading (CPU-only)
        
        Args:
            model_name: Name of the SentenceTransformer model to use
            device: Device to load the model on ('cpu')
        """
        self.model_name = model_name
        self.device = device
        self.model = None  # Lazy-load on first use

    def _ensure_model(self):
        if self.model is None:
            try:
                from sentence_transformers import SentenceTransformer
                self.model = SentenceTransformer(self.model_name, device=self.device)
                logger.info(f"Loaded text vectorization model: {self.model_name} on {self.device}")
            except Exception as e:
                logger.error(f"Failed to load model {self.model_name} on {self.device}: {str(e)}")
                # Re-raise so callers can handle appropriately
                raise

    def status(self) -> dict:
        """Return status of vectorizer without forcing load."""
        loaded = self.model is not None
        dim = None
        try:
            if loaded:
                dim = self.model.get_sentence_embedding_dimension()
        except Exception:
            dim = None
        return {
            "loaded": loaded,
            "model_name": self.model_name,
            "device": self.device,
            "dimension": dim,
        }
    
    def vectorize_text(self, text: str) -> List[float]:
        """
        Convert text to a vector embedding
        
        Args:
            text: Input text to vectorize
            
        Returns:
            List of floats representing the text embedding
        """
        # Ensure model is available (lazy-load)
        self._ensure_model()

        if not text or not isinstance(text, str):
            # Return a zero vector of the correct dimension if input is invalid
            return [0.0] * self.model.get_sentence_embedding_dimension()
        
        try:
            embedding = self.model.encode([text], convert_to_numpy=True, device=self.device)[0]
            return embedding.tolist()
        except Exception as e:
            logger.error(f"Error vectorizing text: {str(e)}")
            # Return a zero vector on error
            return [0.0] * self.model.get_sentence_embedding_dimension()
    
    def vectorize_batch(self, texts: List[str]) -> List[List[float]]:
        """
        Convert a batch of texts to vectors
        
        Args:
            texts: List of texts to vectorize
            
        Returns:
            List of vector embeddings
        """
        if not texts:
            return []
        
        # Ensure model is available (lazy-load)
        self._ensure_model()
        
        try:
            embeddings = self.model.encode(texts, convert_to_numpy=True, device=self.device)
            return embeddings.tolist()
        except Exception as e:
            logger.error(f"Error vectorizing batch: {str(e)}")
            return []
    
    def get_embedding_dimension(self) -> int:
        """
        Get the dimension of the embedding vectors
        
        Returns:
            Integer representing the embedding dimension
        """
        # Ensure model is available (lazy-load)
        self._ensure_model()
        return self.model.get_sentence_embedding_dimension()

# Create a global instance for easy access (lazy-loaded model)
text_vectorizer = TextVectorizer(device='cpu')

def get_embeddings_status() -> dict:
    return text_vectorizer.status()

def generate_embeddings(text: str) -> List[float]:
    """Generate embeddings for a given text using the TextVectorizer"""
    # This function now correctly uses the global instance `text_vectorizer`.
    return text_vectorizer.vectorize_text(text)

def rebuild_vector_index():
    """Rebuild the vector index for businesses and investors"""
    logger.info("Starting vector index rebuild...")
    db = SessionLocal()
    
    try:
        # Fetch all businesses
        businesses = db.execute("SELECT * FROM businesses").fetchall()
        business_embeddings = []
        
        for biz in businesses:
            # Create a concatenated text representation of the business
            biz_text = f"{biz.legal_name} {biz.sector} {biz.location} {biz.description or ''}"
            embedding = text_vectorizer.vectorize_text(biz_text)
            business_embeddings.append((biz.id, embedding))
            logger.debug(f"Generated embedding for business: {biz.id}")
        
        # Fetch all investors
        investors = db.execute("SELECT * FROM investors").fetchall()
        investor_embeddings = []
        
        for inv in investors:
            # Create a concatenated text representation of the investor
            inv_text = f"{inv.fund_name} {inv.sector_prefs} {inv.mandate_text or ''}"
            embedding = text_vectorizer.vectorize_text(inv_text)
            investor_embeddings.append((inv.id, embedding))
            logger.debug(f"Generated embedding for investor: {inv.id}")
        
        # Here you would save the embeddings to your vector database
        # Example: vector_db.upsert(business_embeddings, "businesses")
        # Example: vector_db.upsert(investor_embeddings, "investors")
        
        logger.info(f"Index rebuilt: {len(business_embeddings)} businesses, {len(investor_embeddings)} investors")
        
    except Exception as e:
        logger.error(f"Error rebuilding index: {str(e)}")
        raise
    finally:
        db.close()
        