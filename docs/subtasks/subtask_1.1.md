# Task 1.1: Keycloak and PostgreSQL Setup

## Overview
This document details the steps required to set up Keycloak with PostgreSQL database for the ISO27k1 project.

## Prerequisites
- Docker and Docker Compose installed
- Ports 8080 (Keycloak) and 5432 (PostgreSQL) available
- Basic understanding of Docker networking

## Sub-tasks

### 1. PostgreSQL Setup
- [ ] Create PostgreSQL container configuration
  - [ ] Set up volume for data persistence
  - [ ] Configure environment variables
  - [ ] Set up initialization scripts
  - [ ] Configure network settings

### 2. Keycloak Setup
- [ ] Create Keycloak container configuration
  - [ ] Set up environment variables
  - [ ] Configure database connection
  - [ ] Set up admin credentials
  - [ ] Configure health checks
  - [ ] Set up network settings

### 3. Database Initialization
- [ ] Create initialization scripts
  - [ ] Database creation script
  - [ ] User permissions setup
  - [ ] Schema initialization
  - [ ] Test data insertion (if needed)

### 4. Container Networking
- [ ] Set up Docker network
  - [ ] Configure container communication
  - [ ] Set up port mappings
  - [ ] Configure service dependencies

### 5. Security Configuration
- [ ] Configure PostgreSQL security
  - [ ] Set up strong passwords
  - [ ] Configure user permissions
  - [ ] Set up SSL (if needed)
- [ ] Configure Keycloak security
  - [ ] Set up admin credentials
  - [ ] Configure HTTPS (if needed)
  - [ ] Set up proper CORS

### 6. Testing and Verification
- [ ] Test database connection
  - [ ] Verify PostgreSQL is running
  - [ ] Check database creation
  - [ ] Test user permissions
- [ ] Test Keycloak setup
  - [ ] Verify Keycloak is running
  - [ ] Test admin login
  - [ ] Check database connectivity
  - [ ] Verify health checks

### 7. Documentation
- [ ] Document configuration
  - [ ] Environment variables
  - [ ] Network settings
  - [ ] Security settings
- [ ] Create setup instructions
  - [ ] Installation steps
  - [ ] Configuration steps
  - [ ] Troubleshooting guide

## Configuration Details

### PostgreSQL Configuration
```yaml
Environment Variables:
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: postgres
  POSTGRES_DB: iso27001
  POSTGRES_MULTIPLE_DATABASES: keycloak,iso27001

Ports:
  - 5432:5432

Volumes:
  - postgres_data:/var/lib/postgresql/data
  - ./init-scripts:/docker-entrypoint-initdb.d
```

### Keycloak Configuration
```yaml
Environment Variables:
  KC_BOOTSTRAP_ADMIN_USERNAME: admin
  KC_BOOTSTRAP_ADMIN_PASSWORD: admin
  KC_DB: postgres
  KC_DB_URL: jdbc:postgresql://postgres:5432/keycloak
  KC_DB_USERNAME: postgres
  KC_DB_PASSWORD: postgres
  KC_HOSTNAME_STRICT: false
  KC_HOSTNAME_STRICT_HTTPS: false
  KC_PROXY: edge

Ports:
  - 8080:8080

Health Check:
  test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
  interval: 10s
  timeout: 5s
  retries: 5
```

## Success Criteria
- [ ] PostgreSQL container is running and healthy
- [ ] Keycloak container is running and healthy
- [ ] Database is properly initialized
- [ ] Keycloak can connect to the database
- [ ] Admin console is accessible
- [ ] All security measures are in place
- [ ] Documentation is complete

## Troubleshooting
1. Database Connection Issues
   - Check PostgreSQL logs
   - Verify network connectivity
   - Check credentials

2. Keycloak Startup Issues
   - Check Keycloak logs
   - Verify database connection
   - Check environment variables

3. Container Networking Issues
   - Check Docker network
   - Verify port mappings
   - Check container dependencies

## Notes
- Keep security best practices in mind
- Use strong passwords in production
- Regular backups of PostgreSQL data
- Monitor container health
- Keep documentation updated 