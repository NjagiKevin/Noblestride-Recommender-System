# 📚 API Reference Guide
## FastAPI Recommendation Service

### 🔗 Base Information
- **Base URL**: `http://localhost:8010`
- **API Documentation**: `http://localhost:8010/docs`
- **OpenAPI Schema**: `http://localhost:8010/openapi.json`
- **Content-Type**: `application/json`

---

## 🏥 Health & Status Endpoints

### `GET /health`
System health check endpoint.

**Response**:
```json
{
  "status": "ok",
  "service": "recommender",
  "version": "0.1.0"
}
```

### `GET /`
Root endpoint welcome message.

**Response**:
```json
{
  "message": "Welcome to the Investor–Business Recommender Service!"
}
```

---

## 🤖 Model Management

### `GET /api/model/status`
Get current ML model status and metadata.

**Response**:
```json
{
  "status": "ready",
  "current_model_version": "v20250918_143000",
  "last_training": "2025-09-18T14:30:00.000Z",
  "message": "Model is ready for predictions"
}
```

**Status Values**:
- `ready`: Model is trained and ready for predictions
- `training`: Model is currently being trained

### `POST /api/model/training-complete`
Notify the service that model training is complete (called by Airflow).

**Request Body**:
```json
{
  "model_type": "recommendation_model",
  "training_samples": 1500,
  "training_timestamp": "2025-09-18T14:30:00.000Z",
  "model_version": "v20250918_143000"
}
```

**Response**:
```json
{
  "status": "success",
  "message": "Model v20250918_143000 registered successfully",
  "received_at": "2025-09-18T14:30:15.123Z"
}
```

### `POST /api/model/trigger-training`
Manually trigger model training pipeline.

**Response**:
```json
{
  "status": "success",
  "message": "Model training triggered successfully",
  "timestamp": "2025-09-18T14:30:00.000Z"
}
```

**Error Response** (409 Conflict):
```json
{
  "detail": "Training already in progress"
}
```

### `GET /api/model/health`
Model-specific health check.

**Response**:
```json
{
  "status": "healthy",
  "service": "model-service", 
  "timestamp": "2025-09-18T14:30:00.000Z",
  "model_ready": true
}
```

---

## 🏢 Business Management

### `GET /api/businesses`
Retrieve businesses with pagination and filtering.

**Query Parameters**:
- `limit` (optional): Number of results (default: 10)
- `offset` (optional): Pagination offset (default: 0)
- `sector` (optional): Filter by sector
- `location` (optional): Filter by location

**Example Request**:
```
GET /api/businesses?limit=5&offset=0&sector=fintech
```

**Response**:
```json
{
  "items": [
    {
      "id": "business_123",
      "legal_name": "TechStartup Inc.",
      "sector": "fintech",
      "industry": "Digital Banking",
      "location": "San Francisco, CA",
      "sub_sector": "payments",
      "countries": ["USA"],
      "region": "North America",
      "stage": "Series A",
      "raise_min": 1000000,
      "raise_max": 5000000,
      "instruments": ["equity", "convertible"],
      "impact_flags": ["sustainable", "social-impact"],
      "description": "Digital banking platform for SMEs",
      "core_service": "Banking API",
      "target_clients": ["SME", "Startups"],
      "portfolio_keywords": ["banking", "API", "fintech"],
      "capital_needed": 2000000,
      "createdAt": "2025-09-18T10:00:00.000Z",
      "updatedAt": "2025-09-18T12:00:00.000Z"
    }
  ],
  "total": 1,
  "limit": 5,
  "offset": 0
}
```

### `POST /api/businesses`
Create a new business profile.

**Request Body**:
```json
{
  "legal_name": "New Tech Venture",
  "sector": "healthtech",
  "industry": "Medical Devices",
  "location": "Austin, TX",
  "sub_sector": "diagnostics",
  "countries": ["USA"],
  "region": "North America",
  "stage": "Seed",
  "raise_min": 500000,
  "raise_max": 2000000,
  "instruments": ["equity"],
  "impact_flags": ["healthcare"],
  "description": "AI-powered diagnostic platform",
  "core_service": "Diagnostic AI",
  "target_clients": ["Hospitals", "Clinics"],
  "portfolio_keywords": ["AI", "diagnostics", "healthcare"],
  "capital_needed": 1500000
}
```

**Response** (201 Created):
```json
{
  "id": "business_456",
  "legal_name": "New Tech Venture",
  "sector": "healthtech",
  "industry": "Medical Devices",
  "location": "Austin, TX",
  "capital_needed": 1500000,
  "createdAt": "2025-09-18T14:30:00.000Z",
  "updatedAt": "2025-09-18T14:30:00.000Z"
}
```

### `PUT /api/businesses/{business_id}`
Update an existing business profile.

**Path Parameters**:
- `business_id`: Unique business identifier

**Request Body**: Same as POST (partial updates supported)

### `DELETE /api/businesses/{business_id}`
Delete a business profile.

**Response** (204 No Content)

---

## 👥 Investor Management

### `GET /api/investors`
Retrieve investors with pagination and filtering.

**Query Parameters**:
- `limit` (optional): Number of results (default: 10)
- `offset` (optional): Pagination offset (default: 0)
- `sector_preference` (optional): Filter by preferred sectors
- `region_preference` (optional): Filter by preferred regions

**Response**:
```json
{
  "items": [
    {
      "id": "investor_789",
      "email": "investor@example.com",
      "name": "John Smith",
      "description": "Experienced tech investor",
      "location": "Silicon Valley, CA",
      "role": "Investor",
      "preference_sector": ["fintech", "healthtech"],
      "preference_region": ["North America", "Europe"],
      "total_investments": 25,
      "average_check_size": 1000000,
      "successful_exits": 8,
      "portfolio_ipr": 3.2,
      "phone": "+1-555-0123",
      "createdAt": "2025-09-18T10:00:00.000Z",
      "updatedAt": "2025-09-18T12:00:00.000Z"
    }
  ],
  "total": 1,
  "limit": 10,
  "offset": 0
}
```

### `POST /api/investors`
Create a new investor profile.

**Request Body**:
```json
{
  "email": "newinvestor@example.com",
  "name": "Jane Doe",
  "description": "Angel investor focused on early-stage startups",
  "location": "New York, NY",
  "role": "Angel Investor",
  "preference_sector": ["edtech", "fintech"],
  "preference_region": ["North America"],
  "total_investments": 12,
  "average_check_size": 250000,
  "successful_exits": 3,
  "portfolio_ipr": 2.8,
  "phone": "+1-555-9876",
  "password": "secure_password_123"
}
```

**Response** (201 Created):
```json
{
  "id": "investor_012",
  "email": "newinvestor@example.com",
  "name": "Jane Doe",
  "description": "Angel investor focused on early-stage startups",
  "location": "New York, NY",
  "role": "Angel Investor",
  "preference_sector": ["edtech", "fintech"],
  "preference_region": ["North America"],
  "total_investments": 12,
  "average_check_size": 250000,
  "successful_exits": 3,
  "portfolio_ipr": 2.8,
  "phone": "+1-555-9876",
  "createdAt": "2025-09-18T14:30:00.000Z",
  "updatedAt": "2025-09-18T14:30:00.000Z"
}
```

### `PUT /api/investors/{investor_id}`
Update an existing investor profile.

### `DELETE /api/investors/{investor_id}`
Delete an investor profile.

---

## 🎯 Recommendations

### `POST /api/recommend/businesses-for-investor`
Get personalized business recommendations for an investor.

**Request Body**:
```json
{
  "investor_id": "investor_789",
  "filters": {
    "sectors": ["fintech", "healthtech"],
    "min_funding": 100000,
    "max_funding": 5000000,
    "regions": ["North America", "Europe"],
    "stages": ["Seed", "Series A"],
    "impact_flags": ["sustainable"]
  },
  "limit": 10,
  "include_reasons": true
}
```

**Response**:
```json
{
  "items": [
    {
      "business": {
        "id": "business_123",
        "legal_name": "TechStartup Inc.",
        "sector": "fintech",
        "industry": "Digital Banking",
        "location": "San Francisco, CA",
        "capital_needed": 2000000,
        "description": "Digital banking platform for SMEs",
        "stage": "Series A"
      },
      "reasons": [
        "Sector match: fintech aligns with investor preferences",
        "Funding range matches investor criteria ($2M within $100K-$5M range)",
        "Geographic preference: North America matches investor focus",
        "Stage alignment: Series A fits investor profile",
        "Strong growth potential based on market analysis"
      ],
      "confidence_score": 0.89,
      "ranking": 1
    }
  ],
  "total_matches": 1,
  "processing_time_ms": 145,
  "recommendation_id": "rec_20250918_143045"
}
```

### `POST /api/recommend/investors-for-business`
Get personalized investor recommendations for a business.

**Request Body**:
```json
{
  "business_id": "business_123",
  "filters": {
    "min_check_size": 500000,
    "max_check_size": 10000000,
    "preferred_regions": ["North America"],
    "investment_stages": ["Series A", "Series B"],
    "sector_experience": true
  },
  "limit": 10,
  "include_reasons": true
}
```

**Response**:
```json
{
  "items": [
    {
      "investor": {
        "id": "investor_789",
        "name": "John Smith",
        "description": "Experienced tech investor",
        "location": "Silicon Valley, CA",
        "average_check_size": 1000000,
        "preference_sector": ["fintech", "healthtech"],
        "total_investments": 25,
        "successful_exits": 8
      },
      "reasons": [
        "Sector expertise: Strong track record in fintech investments",
        "Check size match: $1M average aligns with $2M funding need",
        "Geographic proximity: Based in Silicon Valley",
        "Experience level: 25 previous investments with 8 successful exits",
        "Portfolio fit: Business complements existing fintech investments"
      ],
      "confidence_score": 0.92,
      "ranking": 1
    }
  ],
  "total_matches": 1,
  "processing_time_ms": 167,
  "recommendation_id": "rec_20250918_143123"
}
```

### `GET /api/recommend/trending`
Get trending businesses and investment opportunities.

**Query Parameters**:
- `period` (optional): Time period ('day', 'week', 'month') - default: 'week'
- `sector` (optional): Filter by sector
- `limit` (optional): Number of results (default: 10)

**Response**:
```json
{
  "trending_businesses": [
    {
      "business": {
        "id": "business_456",
        "legal_name": "AI Healthcare Solutions",
        "sector": "healthtech",
        "capital_needed": 3000000
      },
      "trend_score": 0.87,
      "recent_interest": 15,
      "growth_indicators": [
        "High investor engagement",
        "Recent product milestones",
        "Strong market traction"
      ]
    }
  ],
  "period": "week",
  "generated_at": "2025-09-18T14:30:00.000Z"
}
```

---

## 📊 Ranking & Scoring

### `POST /api/rank/users`
Rank users (investors) based on specific criteria.

**Request Body**:
```json
{
  "criteria": {
    "investment_experience": 0.3,
    "sector_expertise": 0.4,
    "geographic_alignment": 0.2,
    "portfolio_performance": 0.1
  },
  "context": {
    "target_sector": "fintech",
    "target_region": "North America",
    "funding_stage": "Series A"
  },
  "limit": 20
}
```

**Response**:
```json
{
  "items": [
    {
      "user": {
        "id": "investor_789",
        "name": "John Smith",
        "description": "Experienced tech investor",
        "location": "Silicon Valley, CA"
      },
      "reasons": [
        "Strong sector expertise in fintech (40% weight)",
        "Excellent geographic alignment with target region",
        "Above-average portfolio performance (3.2 IPR)"
      ],
      "total_score": 0.91,
      "ranking": 1
    }
  ]
}
```

### `POST /api/rank/deals`
Rank deals based on investor preferences and market conditions.

**Request Body**:
```json
{
  "investor_id": "investor_789",
  "criteria": {
    "sector_match": 0.35,
    "funding_alignment": 0.25,
    "geographic_preference": 0.15,
    "growth_potential": 0.25
  },
  "filters": {
    "max_deal_size": 5000000,
    "preferred_sectors": ["fintech", "healthtech"],
    "exclude_stages": ["Pre-seed"]
  },
  "limit": 15
}
```

**Response**:
```json
{
  "items": [
    {
      "deal": {
        "deal_id": "deal_345",
        "title": "Series A Funding - TechStartup Inc.",
        "description": "Raising $2M for product expansion",
        "deal_size": 2000000,
        "deal_type": "equity",
        "status": "active",
        "sector": "fintech"
      },
      "business": {
        "id": "business_123",
        "legal_name": "TechStartup Inc.",
        "sector": "fintech",
        "location": "San Francisco, CA"
      },
      "reasons": [
        "Perfect sector match: fintech aligns with investor focus",
        "Optimal deal size: $2M within investor range",
        "Strong growth metrics and market opportunity",
        "Geographic alignment with investor preferences"
      ],
      "total_score": 0.88,
      "ranking": 1
    }
  ]
}
```

---

## 📝 Feedback System

### `POST /api/feedback`
Submit feedback on recommendations.

**Request Body**:
```json
{
  "investor_id": "investor_789",
  "business_id": "business_123",
  "feedback_type": "positive",
  "recommendation_id": "rec_20250918_143045",
  "details": {
    "rating": 5,
    "comments": "Excellent match, proceeded with initial discussion",
    "action_taken": "contacted_business"
  }
}
```

**Feedback Types**:
- `positive`: Recommendation was helpful/relevant
- `negative`: Recommendation was not relevant
- `neutral`: Recommendation was okay but not actionable

**Response**:
```json
{
  "status": "success",
  "feedback_id": "feedback_678",
  "message": "Feedback recorded successfully",
  "timestamp": "2025-09-18T14:30:00.000Z"
}
```

### `GET /api/feedback/analytics`
Get feedback analytics and model performance metrics.

**Query Parameters**:
- `start_date` (optional): Start date for analytics (ISO format)
- `end_date` (optional): End date for analytics (ISO format)
- `investor_id` (optional): Filter by specific investor
- `business_id` (optional): Filter by specific business

**Response**:
```json
{
  "summary": {
    "total_feedback": 1247,
    "positive_feedback": 892,
    "negative_feedback": 278,
    "neutral_feedback": 77,
    "average_rating": 4.2,
    "recommendation_accuracy": 0.71
  },
  "trends": {
    "weekly_positive_rate": 0.73,
    "sector_performance": {
      "fintech": 0.78,
      "healthtech": 0.69,
      "edtech": 0.64
    },
    "geographic_performance": {
      "North America": 0.75,
      "Europe": 0.68,
      "Asia": 0.62
    }
  },
  "model_metrics": {
    "precision": 0.72,
    "recall": 0.68,
    "f1_score": 0.70,
    "last_evaluation": "2025-09-18T02:00:00.000Z"
  }
}
```

---

## 🛠 Debug & Utilities

### `GET /api/debug/system-info`
Get comprehensive system information (development only).

**Response**:
```json
{
  "system": {
    "service_name": "Investor-Business Recommender Service",
    "version": "0.1.0",
    "environment": "development",
    "uptime_seconds": 3600,
    "current_time": "2025-09-18T14:30:00.000Z"
  },
  "database": {
    "status": "connected",
    "pool_size": 10,
    "active_connections": 3,
    "total_businesses": 150,
    "total_investors": 75,
    "total_deals": 89,
    "total_feedback": 1247
  },
  "model": {
    "status": "ready",
    "current_version": "v20250918_143000",
    "last_training": "2025-09-18T02:00:00.000Z",
    "training_samples": 1500
  }
}
```

---

## 📚 Data Schemas

### Business Schema
```json
{
  "id": "string",
  "legal_name": "string",
  "sector": "string",
  "industry": "string", 
  "location": "string",
  "sub_sector": "string",
  "countries": ["string"],
  "region": "string",
  "stage": "string",
  "raise_min": "number",
  "raise_max": "number", 
  "instruments": ["string"],
  "impact_flags": ["string"],
  "description": "string",
  "core_service": "string",
  "target_clients": ["string"],
  "portfolio_keywords": ["string"],
  "capital_needed": "number",
  "createdAt": "datetime",
  "updatedAt": "datetime"
}
```

### Investor Schema
```json
{
  "id": "string",
  "email": "string",
  "name": "string",
  "description": "string",
  "location": "string",
  "role": "string",
  "preference_sector": ["string"],
  "preference_region": ["string"],
  "total_investments": "number",
  "average_check_size": "number",
  "successful_exits": "number",
  "portfolio_ipr": "number",
  "phone": "string",
  "createdAt": "datetime",
  "updatedAt": "datetime"
}
```

### Deal Schema
```json
{
  "deal_id": "uuid",
  "title": "string",
  "description": "string",
  "deal_size": "number",
  "deal_type": "string",
  "status": "string",
  "visibility": "string",
  "created_by": "number",
  "target_company_id": "number",
  "sector_id": "uuid",
  "subsector_id": "uuid",
  "createdAt": "datetime",
  "updatedAt": "datetime"
}
```

---

## ❌ Error Responses

### Standard Error Format
```json
{
  "detail": "Error message describing what went wrong",
  "error_code": "SPECIFIC_ERROR_CODE",
  "timestamp": "2025-09-18T14:30:00.000Z",
  "request_id": "req_123456789"
}
```

### HTTP Status Codes

| Code | Meaning | Example |
|------|---------|---------|
| 200 | Success | Successful API call |
| 201 | Created | Resource created successfully |  
| 400 | Bad Request | Invalid request parameters |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Resource conflict (e.g., training in progress) |
| 422 | Validation Error | Request validation failed |
| 500 | Internal Error | Server-side error |

### Common Error Scenarios

#### Validation Error (422)
```json
{
  "detail": [
    {
      "loc": ["body", "email"],
      "msg": "field required",
      "type": "value_error.missing"
    },
    {
      "loc": ["body", "capital_needed"],
      "msg": "ensure this value is greater than 0",
      "type": "value_error.number.not_gt"
    }
  ]
}
```

#### Not Found Error (404)
```json
{
  "detail": "Business with id 'business_999' not found"
}
```

#### Service Unavailable (500)
```json
{
  "detail": "Database connection failed",
  "error_code": "DATABASE_ERROR",
  "timestamp": "2025-09-18T14:30:00.000Z"
}
```

---

## 📈 Rate Limits

### Current Limits
- **General API calls**: 100 requests per minute per IP
- **Recommendation endpoints**: 20 requests per minute per IP
- **Model training triggers**: 5 requests per hour per IP

### Rate Limit Headers
```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 85
X-RateLimit-Reset: 1695046260
```

---

## 🔐 Authentication

Currently, the API operates without authentication for development purposes. For production deployment, implement:

1. **JWT Token Authentication**
2. **API Key Authentication**
3. **OAuth 2.0 Integration**

### Future Authentication Example
```http
Authorization: Bearer <jwt_token>
X-API-Key: <api_key>
```

---

*API Reference Last Updated: September 18, 2025*  
*API Version: 1.0*  
*Service Version: 0.1.0*