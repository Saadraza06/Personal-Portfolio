# 🚀 Muhammad Saad Raza — Portfolio Deployment Guide

## 📁 Files Required
Make sure ALL files are in the **same folder**:
```
your-folder/
├── Dockerfile
├── nginx.conf
└── saad_raza_portfolio.html
```

---

## ☁️ Deploy to Google Cloud Run (Fixed)

### Step 1 — Set your project
```bash
gcloud config set project YOUR_PROJECT_ID
```

### Step 2 — Build & push image to Google Container Registry
```bash
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/saad-portfolio
```

### Step 3 — Deploy to Cloud Run
```bash
gcloud run deploy saad-portfolio \
  --image gcr.io/YOUR_PROJECT_ID/saad-portfolio \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080
```

✅ Your portfolio will be live at the URL Cloud Run provides!

---

## 🐳 Deploy Locally (Test First)

### Build & run
```bash
docker build -t saad-portfolio .
docker run -d -e PORT=8080 -p 8080:8080 --name saad-portfolio saad-portfolio
```

### Open in browser
```
http://localhost:8080
```

### Stop container
```bash
docker stop saad-portfolio && docker rm saad-portfolio
```

---

## 🌐 Deploy to Railway (Free & Easy)

1. Push all 3 files to a GitHub repo
2. Go to https://railway.app → **New Project → Deploy from GitHub**
3. Select your repo — Railway auto-detects the Dockerfile
4. Add env variable: `PORT=8080`
5. Your portfolio goes live with a public URL instantly!

---

## 🟣 Deploy to Render (Free)

1. Push files to GitHub
2. Go to https://render.com → **New Web Service**
3. Connect your GitHub repo
4. Set **Environment** to `Docker`
5. Set env variable: `PORT=8080`
6. Click **Deploy** — get a free `.onrender.com` URL

---

## 💡 Why This Fix Works
Cloud Run injects a `PORT` environment variable (default 8080) at runtime.
The original Dockerfile hardcoded port 80 which caused the container to fail.
This version uses `envsubst` to dynamically inject `$PORT` into nginx config at startup.
