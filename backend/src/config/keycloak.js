const session = require('express-session');
const Keycloak = require('keycloak-connect');

// Session configuration
const memoryStore = new session.MemoryStore();

const sessionConfig = {
    secret: process.env.SESSION_SECRET || 'your-secret-key',
    resave: false,
    saveUninitialized: true,
    store: memoryStore
};

// Keycloak configuration
const keycloakConfig = {
    realm: process.env.KEYCLOAK_REALM || 'iso27k1',
    'auth-server-url': process.env.KEYCLOAK_URL || 'http://localhost:8080',
    'ssl-required': 'external',
    resource: process.env.KEYCLOAK_CLIENT_ID || 'backend',
    'public-client': true,
    'confidential-port': 0
};

// Initialize Keycloak
const keycloak = new Keycloak({ store: memoryStore }, keycloakConfig);

module.exports = {
    keycloak,
    sessionConfig
}; 