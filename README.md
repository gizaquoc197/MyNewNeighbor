My New Neighbor

My New Neighbor is a mobile app that helps people—especially older immigrants—discover nearby organizations, events, and community connections in a simple, privacy-conscious way.

Repo Structure
MyNewNeighbor/
├─ frontend/        # Expo React Native app
├─ backend/         # Node/Express API
├─ README.md        # You are here
└─ .gitignore

Prerequisites

Make sure you have the following installed before starting:

- Node.js (LTS)
Download from: https://nodejs.org

Verify:

node -v
npm -v
npx -v

- Git
- Expo Go app (to run on a phone)

Getting Started (Run Everything Locally)

You will need two terminals: one for backend, one for frontend.

1️⃣ Backend Setup (API)
cd backend
cp .env.example .env
npm install
npm run dev


Expected output:

API running on http://localhost:4000

Verify backend

Open in browser:

http://localhost:4000/health


You should see:

{ "ok": true }

2️⃣ Frontend Setup (Expo)
cd frontend
cp .env.example .env
npm install
npx expo start


Press w to open the app in a web browser

Or scan the QR code with Expo Go on your phone

If everything is set up correctly, the app will display:

Backend status:
{"ok":true}

Environment Variables
Backend (backend/.env)
PORT=4000

Frontend (frontend/.env)
EXPO_PUBLIC_API_BASE_URL=http://127.0.0.1:4000

⚠️ If you change .env files, restart Expo with:

npx expo start -c

Common Troubleshooting
Backend works in browser, but frontend says “API not reachable”

Make sure the backend is still running

Ensure EXPO_PUBLIC_API_BASE_URL is correct

Restart Expo with cache cleared: expo start -c

Using a physical phone instead of web

Replace 127.0.0.1 with your computer’s local IP:

EXPO_PUBLIC_API_BASE_URL=http://192.168.X.X:4000


Phone and computer must be on the same Wi-Fi network

Port already in use

Stop the process using port 4000 or change PORT in backend/.env

Git Notes

node_modules and .env files are intentionally ignored

Each developer should create their own .env from .env.example