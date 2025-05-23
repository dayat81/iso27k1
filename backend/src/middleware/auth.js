const { keycloak } = require('../config/keycloak');

// Middleware to protect routes
const protect = keycloak.protect();

// Middleware to check for specific roles
const checkRole = (role) => {
    return keycloak.protect(role);
};

// Middleware to get user info
const getUserInfo = async (req, res, next) => {
    try {
        const token = req.kauth.grant.access_token;
        req.user = {
            id: token.content.sub,
            username: token.content.preferred_username,
            email: token.content.email,
            roles: token.content.realm_access?.roles || [],
            firstName: token.content.given_name,
            lastName: token.content.family_name
        };
        next();
    } catch (error) {
        res.status(401).json({
            message: 'Not authorized to access this route'
        });
    }
};

module.exports = {
    protect,
    checkRole,
    getUserInfo
}; 