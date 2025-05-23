# Project Structure

```
iso27001/
├── docker-compose.yml
├── frontend/
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   ├── src/
│   │   ├── components/
│   │   │   ├── common/
│   │   │   ├── compliance/
│   │   │   ├── risk/
│   │   │   └── audit/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── utils/
│   │   └── App.tsx
│   └── public/
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   └── app.ts
│   └── tests/
├── prometheus/
│   └── prometheus.yml
└── README.md
```

## Component Descriptions

### Frontend
- **components/**: Reusable UI components
  - **common/**: Shared components (buttons, forms, etc.)
  - **compliance/**: ISO 27001 compliance management components
  - **risk/**: Risk assessment and management components
  - **audit/**: Audit management components
- **pages/**: Main application pages
- **services/**: API integration and business logic
- **utils/**: Helper functions and utilities

### Backend
- **config/**: Application configuration
- **controllers/**: Request handlers
- **middleware/**: Custom middleware (auth, logging, etc.)
- **models/**: Database models
- **routes/**: API route definitions
- **services/**: Business logic and external service integration
- **tests/**: Unit and integration tests

### Infrastructure
- **docker-compose.yml**: Service orchestration
- **prometheus/**: Monitoring configuration
- **frontend/Dockerfile**: Frontend container configuration
- **backend/Dockerfile**: Backend container configuration

## Key Features Implementation

1. **Authentication & Authorization**
   - Keycloak integration
   - Role-based access control
   - Session management

2. **Document Management**
   - MinIO integration for file storage
   - Version control
   - Access control

3. **Risk Management**
   - Risk assessment workflows
   - Risk treatment planning
   - Risk monitoring

4. **Compliance Tracking**
   - Control implementation tracking
   - Compliance status reporting
   - Audit management

5. **Monitoring & Logging**
   - Prometheus metrics
   - Grafana dashboards
   - ELK stack integration

## Development Workflow

1. **Local Development**
   ```bash
   # Start all services
   docker-compose up -d
   
   # Start specific service
   docker-compose up -d frontend
   ```

2. **Building**
   ```bash
   # Build all services
   docker-compose build
   
   # Build specific service
   docker-compose build frontend
   ```

3. **Testing**
   ```bash
   # Run frontend tests
   docker-compose run frontend pnpm test
   
   # Run backend tests
   docker-compose run backend pnpm test
   ```

4. **Deployment**
   ```bash
   # Deploy to production
   docker-compose -f docker-compose.prod.yml up -d
   ``` 