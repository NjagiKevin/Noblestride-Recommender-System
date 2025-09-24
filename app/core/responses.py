from fastapi.responses import JSONResponse
from typing import Any, Optional, Dict
import json


def remove_none_from_dict(obj):
    if isinstance(obj, dict):
        return {k: remove_none_from_dict(v) for k, v in obj.items() if v is not None}
    elif isinstance(obj, list):
        return [remove_none_from_dict(elem) for elem in obj]
    else:
        return obj


class NoneExcludingJSONResponse(JSONResponse):
    def render(self, content: Any) -> bytes:
        cleaned_content = remove_none_from_dict(content)
        return json.dumps(
            cleaned_content,
            ensure_ascii=False,
            allow_nan=False,
            indent=None,
            separators=(",", ":"),
        ).encode("utf-8")


def create_response(data: Any = None, message: str = "", meta: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
    """Standard API response envelope used across the service."""
    envelope = {
        "success": True,
        "message": message,
        "data": data if data is not None else {},
    }
    if meta is not None:
        envelope["meta"] = meta
    return envelope
