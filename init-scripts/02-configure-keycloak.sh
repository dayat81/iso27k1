#!/bin/bash

# Wait for Keycloak to be ready
echo "Waiting for Keycloak to be ready..."
until curl -s http://keycloak:8080/health > /dev/null; do
    sleep 5
done

# Login to Keycloak
echo "Logging in to Keycloak..."
/opt/keycloak/bin/kcadm.sh config credentials \
    --server http://localhost:8080 \
    --realm master \
    --user admin \
    --password admin

# Create realm
echo "Creating realm iso27k1..."
/opt/keycloak/bin/kcadm.sh create realms \
    -s realm=iso27k1 \
    -s enabled=true

# Create client
echo "Creating client iso27k1..."
/opt/keycloak/bin/kcadm.sh create clients \
    -r iso27k1 \
    -s clientId=iso27k1 \
    -s enabled=true \
    -s publicClient=false \
    -s clientAuthenticatorType="client-secret" \
    -s secret="your-client-secret" \
    -s redirectUris='["http://localhost:3000/*"]' \
    -s webOrigins='["http://localhost:3000"]' \
    -s standardFlowEnabled=true \
    -s directAccessGrantsEnabled=true

# Create roles
echo "Creating roles..."
for role in "admin" "user"; do
    /opt/keycloak/bin/kcadm.sh create roles \
        -r iso27k1 \
        -s name=$role
done

# Create test users
echo "Creating test users..."
# Admin user
/opt/keycloak/bin/kcadm.sh create users \
    -r iso27k1 \
    -s username=admin \
    -s enabled=true
/opt/keycloak/bin/kcadm.sh set-password \
    -r iso27k1 \
    --username admin \
    --new-password admin123
/opt/keycloak/bin/kcadm.sh add-roles \
    -r iso27k1 \
    --uusername admin \
    --rolename admin

# Regular user
/opt/keycloak/bin/kcadm.sh create users \
    -r iso27k1 \
    -s username=user \
    -s enabled=true
/opt/keycloak/bin/kcadm.sh set-password \
    -r iso27k1 \
    --username user \
    --new-password user123
/opt/keycloak/bin/kcadm.sh add-roles \
    -r iso27k1 \
    --uusername user \
    --rolename user

echo "Keycloak configuration completed!" 