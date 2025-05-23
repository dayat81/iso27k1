# Test Cases for Task 1.1: Keycloak and PostgreSQL Setup

## Test Case 1: PostgreSQL Container Health
- **Objective:** Ensure the PostgreSQL container is running and healthy
- **Steps:**
  1. Run `docker compose -f docker-compose.auth.yml up -d`
  2. Run `docker compose -f docker-compose.auth.yml ps`
- **Expected Result:**
  - The `auth-postgres` container status is `healthy`

## Test Case 2: Keycloak Container Health
- **Objective:** Ensure the Keycloak container is running and healthy
- **Steps:**
  1. Run `docker compose -f docker-compose.auth.yml up -d`
  2. Run `docker compose -f docker-compose.auth.yml ps`
- **Expected Result:**
  - The `auth-keycloak` container status is `healthy`

## Test Case 3: Database Initialization
- **Objective:** Verify that both `keycloak` and `iso27001` databases are created
- **Steps:**
  1. Enter the PostgreSQL container: `docker compose -f docker-compose.auth.yml exec postgres psql -U postgres`
  2. Run `\l` to list databases
- **Expected Result:**
  - Both `keycloak` and `iso27001` databases are present

## Test Case 4: Keycloak Admin Console Access
- **Objective:** Ensure the Keycloak admin console is accessible
- **Steps:**
  1. Open browser and go to `http://localhost:8080/admin`
  2. Login with username `admin` and password `admin`
- **Expected Result:**
  - Admin console loads and login is successful

## Test Case 5: Keycloak Database Connectivity
- **Objective:** Ensure Keycloak can connect to PostgreSQL
- **Steps:**
  1. Check Keycloak logs: `docker compose -f docker-compose.auth.yml logs keycloak`
- **Expected Result:**
  - No database connection errors in logs

## Test Case 6: Security Checks
- **Objective:** Ensure default credentials are set and can be changed
- **Steps:**
  1. Attempt to login with default credentials
  2. Change admin password in Keycloak admin console
- **Expected Result:**
  - Login works with default, and password can be changed

---

Add more test cases as needed for further verification or edge cases. 