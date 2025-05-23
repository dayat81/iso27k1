const request = require('supertest');
const app = require('../app');
const { keycloak } = require('../config/keycloak');

// Mock Keycloak middleware
jest.mock('keycloak-connect', () => {
    return jest.fn().mockImplementation(() => ({
        middleware: () => (req, res, next) => next(),
        protect: () => (req, res, next) => {
            // Mock authenticated user
            req.kauth = {
                grant: {
                    access_token: {
                        token: 'mock-token',
                        content: {
                            sub: 'user-123',
                            preferred_username: 'testuser',
                            email: 'test@example.com',
                            realm_access: {
                                roles: ['user']
                            },
                            given_name: 'Test',
                            family_name: 'User'
                        }
                    }
                }
            };
            next();
        }
    }));
});

describe('Authentication Endpoints', () => {
    describe('GET /api/auth/login', () => {
        it('should return successful login response with user info', async () => {
            const response = await request(app)
                .get('/api/auth/login')
                .expect(200);

            expect(response.body).toHaveProperty('message', 'Login successful');
            expect(response.body).toHaveProperty('user');
            expect(response.body.user).toHaveProperty('sub', 'user-123');
            expect(response.body.user).toHaveProperty('preferred_username', 'testuser');
        });
    });

    describe('GET /api/auth/user', () => {
        it('should return user information', async () => {
            const response = await request(app)
                .get('/api/auth/user')
                .expect(200);

            expect(response.body).toHaveProperty('user');
            expect(response.body.user).toHaveProperty('id', 'user-123');
            expect(response.body.user).toHaveProperty('username', 'testuser');
            expect(response.body.user).toHaveProperty('email', 'test@example.com');
            expect(response.body.user).toHaveProperty('roles');
            expect(response.body.user).toHaveProperty('firstName', 'Test');
            expect(response.body.user).toHaveProperty('lastName', 'User');
        });
    });

    describe('GET /api/auth/logout', () => {
        it('should return successful logout message', async () => {
            const response = await request(app)
                .get('/api/auth/logout')
                .expect(200);

            expect(response.body).toHaveProperty('message', 'Logout successful');
        });
    });

    describe('GET /api/auth/refresh', () => {
        it('should return refreshed token', async () => {
            const response = await request(app)
                .get('/api/auth/refresh')
                .expect(200);

            expect(response.body).toHaveProperty('message', 'Token refreshed successfully');
            expect(response.body).toHaveProperty('token', 'mock-token');
        });
    });
}); 