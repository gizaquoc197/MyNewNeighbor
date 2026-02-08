# My New Neighbor

My New Neighbor is a mobile app that helps people—especially older immigrants—discover nearby organizations, events, and community connections in a simple, privacy-conscious way.

---

## Repository Structure

```
MyNewNeighbor/
├─ docker-compose.yml/
├─ migrations/
  └─ 001_init.sql
└─ seed.sql
├─ frontend/ # Expo React Native app
├─ backend/ # Node/Express API
├─ README.md # Project documentation
└─ .gitignore
```


---

## Prerequisites

Install the following before starting:

- **Node.js (LTS)**  
  Download from https://nodejs.org

  Verify installation:
  ```bash
  node -v
  npm -v
  npx -v
- **Git**
- **Expo Go** 
- **Docker Desktop**
  Download from https://www.docker.com/products/docker-desktop/

---

## Getting Started (Local Development)
You will need **two terminals**:
- one for backend
- one for frontend

### 1. Backend Setup (API)
```bash
cd backend
cp .env.example .env
npm install
npm run dev
```
Expected output:

```nginx
API running on http://localhost:4000
```

**Verify backend**

Open in a browser:

```bash
https://localhost:4000/health
```

You should see:

```json
{ "ok" : true }
```
### 2. Frontend Setup (Expo)
```bash
cd frontend
cp .env.example .env
npm install
npx expo start
```
- Press `w` to open the app in a web browser
- Or scan the QR code with **Expo Go** on your phone

If everything is configured correctly, the app will display:

```lua
Backend status:
{"ok":true}
```
---

## Environment Variables
### Backend (`backend/.env`)
```env
PORT=4000
```
### Frontend (`frontend/.env`)
```env
EXPO_PUBLIC_API_BASE_URL=http://127.0.0.1:4000

```
> ⚠️ Important: if you change any `.env` file, restart Expo with cache cleared:
```bash
npx expo start -c
```
---

## Database Setup
### 1. Start Postgres (Docker)
From the project root:
```bash
docker compose up -d
```
Verify
```bash
docker compose ps
```
You should see:
- mynewneighbor_db
- Status: Up (healthy)

### 2. Database Connection String

From host machine (Node backend):
```bash
postgres://app:app_pw@localhost:5432/mynewneighbor
```
From another Docker container:
```bash
postgres://app:app_pw@db:5432/mynewneighbor
```
---

## Schema Migration
Run intial migration
```bash
docker exec -i mynewneighbor_db psql -U app -d mynewneighbor < migrations/001_init.sql
```
This creates all Week 1 tables, including:
- users
- organizations
- events
- activities
- conversations
- messages
- relationship tables

Design notes:
- Connections are unordered
- Blocks are directional
- Conversations
  - may reference event_id, activity_id, or neither
  - enforced via CHECK constraint

---

## Seed Data (Demo)
Run seed script
```bash
docker exec -i mynewneighbor_db psql -U app -d mynewneighbor < seed.sql
```
Seed contents
- 3 organizations
- 4 events
- 3 activities
- Users, followers, RSVPs, activity requests
- Sample conversations and messages

Re-run safety
- Seed script uses TRUNCATE + INSERT
- Safe to re-run in development
- Do not run in production

---

## Git Notes
### General Notes
- Run `npm run format` before committing code (for formatting uniform)
- Run `docker compose up -d` when you start your coding session
- Run `docker exec -i mynewneighbor_db psql -U app -d mynewneighbor < migrations/00X_some_change.sql` when you change database schema
- Run `docker exec -i mynewneighbor_db psql -U app -d mynewneighbor < seed.sql` when you want fresh demo data
- node_modules and .env files are intentionally ignored
- Each developer should create their own .env from .env.example
### EPIC A checkpoint
```bash
git clone <repo>
cd MyNewNeighbor/backend && cp .env.example .env && npm i && npm run dev
cd ../frontend && cp .env.example .env && npm i && npx expo start`
```

If you can run both -> pass
### EPIC B checkpoint

```bash
git clone <repo>
docker compose up -d
docker exec -i mynewneighbor_db psql -U app -d mynewneighbor < migrations/001_init.sql
docker exec -i mynewneighbor_db psql -U app -d mynewneighbor < seed.sql
```