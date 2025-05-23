#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print test results
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
    fi
}

echo "Starting verification of Keycloak and PostgreSQL setup..."

# Test Case 1: PostgreSQL Container Health
echo -e "\nTest Case 1: PostgreSQL Container Health"
docker compose -f docker-compose.auth.yml ps | grep "auth-postgres" | grep -q "healthy"
print_result $? "PostgreSQL container is healthy"

# Test Case 2: Keycloak Container Health
echo -e "\nTest Case 2: Keycloak Container Health"
docker compose -f docker-compose.auth.yml ps | grep "auth-keycloak" | grep -q "healthy"
print_result $? "Keycloak container is healthy"

# Test Case 3: Database Initialization
echo -e "\nTest Case 3: Database Initialization"
DB_CHECK=$(docker compose -f docker-compose.auth.yml exec -T postgres psql -U postgres -c "\l" | grep -E "keycloak|iso27001")
if echo "$DB_CHECK" | grep -q "keycloak" && echo "$DB_CHECK" | grep -q "iso27001"; then
    print_result 0 "Both keycloak and iso27001 databases exist"
else
    print_result 1 "Database initialization failed"
fi

# Test Case 4: Keycloak Admin Console Access
echo -e "\nTest Case 4: Keycloak Admin Console Access"
if curl -s -f "http://localhost:8080/admin" > /dev/null; then
    print_result 0 "Keycloak admin console is accessible"
else
    print_result 1 "Keycloak admin console is not accessible"
fi

# Test Case 5: Keycloak Database Connectivity
echo -e "\nTest Case 5: Keycloak Database Connectivity"
DB_ERRORS=$(docker compose -f docker-compose.auth.yml logs keycloak | grep -i "database connection error")
if [ -z "$DB_ERRORS" ]; then
    print_result 0 "No database connection errors found in Keycloak logs"
else
    print_result 1 "Database connection errors found in Keycloak logs"
fi

# Test Case 6: Security Checks
echo -e "\nTest Case 6: Security Checks"
echo "Note: Manual verification required for password change"
if curl -s -f "http://localhost:8080/realms/master/protocol/openid-connect/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "username=admin" \
    -d "password=admin" \
    -d "grant_type=password" \
    -d "client_id=admin-cli" > /dev/null; then
    print_result 0 "Default admin credentials are working"
else
    print_result 1 "Default admin credentials are not working"
fi

echo -e "\nVerification complete!"
echo "Please manually verify the following:"
echo "1. Access http://localhost:8080/admin and login with admin/admin"
echo "2. Change the admin password in the Keycloak admin console" 