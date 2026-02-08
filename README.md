# My New Neighbor

My New Neighbor is a mobile app that helps people—especially older immigrants—discover nearby organizations, events, and community connections in a simple, privacy-conscious way.

---

## Repository Structure

```
MyNewNeighbor/
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

## Git Notes
- Run `npm run format` before committing code.
- node_modules and .env files are intentionally ignored
- Each developer should create their own .env from .env.example