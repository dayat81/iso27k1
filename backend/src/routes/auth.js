const express = require('express');
const router = express.Router();
const { keycloak } = require('../config/keycloak');
const { protect, getUserInfo } = require('../middleware/auth');

// Login endpoint - handled by Keycloak
router.get('/login', keycloak.protect(), (req, res) => {
    res.json({
        message: 'Login successful',
        user: req.kauth.grant.access_token.content
    });
});

// Get user info endpoint
router.get('/user', protect, getUserInfo, (req, res) => {
    res.json({
        user: req.user
    });
});

// Logout endpoint
router.get('/logout', keycloak.protect(), (req, res) => {
    res.json({
        message: 'Logout successful'
    });
});

// Refresh token endpoint
router.get('/refresh', keycloak.protect(), (req, res) => {
    res.json({
        message: 'Token refreshed successfully',
        token: req.kauth.grant.access_token.token
    });
});

module.exports = router; 