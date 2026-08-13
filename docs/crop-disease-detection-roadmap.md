# Crop Disease Detection + Farmer Advisory App — Build Roadmap

## Problem
Farmers lose yield due to late disease detection.

## MVP
Upload/click a photo of a leaf → ML model classifies disease → shows treatment advice in local language.

## Tech Stack
- **ML:** Python, TensorFlow/Keras, MobileNet (Transfer Learning), PlantVillage Dataset, Google Colab
- **Backend:** Python, FastAPI, Uvicorn
- **Frontend:** React.js / Flutter
- **Design:** Figma
- **Database:** JSON/CSV, Google Translate API
- **Deployment:** Git/GitHub, Docker, Render/Vercel
- **Scaling:** OpenWeatherMap API, Twilio (SMS/IVR)

---

## Team Split (6)
1. ML Engineer
2. Backend Dev
3. Frontend Dev
4. UI/UX Designer
5. Content/Data person
6. Presenter/Integrator

---

## Step-by-Step Build Plan

### Step 1 — Kickoff (Day 1)
- [ ] Finalize crop(s) and disease classes to support (start with 8–10 classes, e.g. tomato/potato leaf diseases from PlantVillage)
- [ ] Set up shared GitHub repo, folder structure (`/ml`, `/backend`, `/frontend`, `/design`, `/data`)
- [ ] Set up a shared Google Drive/Notion for assets and content

### Step 2 — ML Model (ML Engineer)
- [ ] Download PlantVillage dataset (Kaggle)
- [ ] Set up Google Colab notebook with GPU runtime
- [ ] Load MobileNet (pretrained on ImageNet), freeze base layers
- [ ] Add classification head for your chosen disease classes
- [ ] Train with data augmentation (rotation, flip, zoom)
- [ ] Evaluate accuracy, fix class imbalance if needed
- [ ] Export model as `.h5` or convert to `.tflite` for lighter deployment
- [ ] Share exported model file with Backend Dev

### Step 3 — Backend API (Backend Dev)
- [ ] Set up FastAPI project, virtual environment
- [ ] Write `/predict` endpoint: accepts image upload, runs inference, returns JSON (disease name, confidence score)
- [ ] Load the ML model once at startup (not per request)
- [ ] Add CORS middleware so frontend can call the API
- [ ] Test locally with Postman/curl using sample leaf images
- [ ] Containerize with Docker (optional but recommended)
- [ ] Deploy to Render/Railway for a live demo URL

### Step 4 — UI/UX Design (Designer)
- [ ] Research 2–3 existing agri apps (Kisan Suvidha, Plantix) for reference
- [ ] Design wireframes in Figma: home → capture/upload → result screen
- [ ] Prioritize icons over text, large tap targets, high contrast (for outdoor use)
- [ ] Build interactive prototype for demo/pitch
- [ ] Hand off design specs (colors, spacing, components) to Frontend Dev

### Step 5 — Frontend App (Frontend Dev)
- [ ] Set up React or Flutter project
- [ ] Build photo capture/upload screen (camera + gallery)
- [ ] Show image preview before submission
- [ ] Call backend `/predict` API, handle loading/error states
- [ ] Display result: disease name, confidence, and treatment advice
- [ ] Match UI to Figma design
- [ ] Add language toggle (English/Hindi/regional)

### Step 6 — Content & Data (Content/Data person)
- [ ] Build disease → remedy JSON/CSV, keyed to the exact class labels from the ML model
- [ ] Source remedies from reliable sources (ICAR, KVK, state agri department advisories — not random blogs)
- [ ] Translate to Hindi/regional language using Google Translate API as first pass
- [ ] Manually review translations for accuracy (pesticide instructions must be correct)
- [ ] Hand off final dataset to Backend Dev to wire into API response

### Step 7 — Integration (Presenter/Integrator)
- [ ] Connect frontend → backend → model → content database end-to-end
- [ ] Test full flow with real leaf photos (different lighting/angles)
- [ ] Fix edge cases (blurry photo, no leaf detected, low confidence)
- [ ] Record screen-capture demo video
- [ ] Build SIH pitch deck: problem, uniqueness, tech stack, feasibility, impact, prototype
- [ ] Prepare answers for likely judge questions (cost, feasibility, why better than Plantix, offline usage)

### Step 8 — Testing & Polish (Whole team)
- [ ] Test on actual mobile devices, not just localhost
- [ ] Check performance on slow/weak internet
- [ ] Verify translations display correctly (no broken characters)
- [ ] Final walkthrough rehearsal before submission/demo day

---

## Scaling Features (Post-MVP / Roadmap Slide Only)
Do **not** build these before the core loop works — show them as future scope in the pitch deck.

- [ ] Weather API integration (OpenWeatherMap) — disease risk alerts based on humidity/temperature
- [ ] Soil data integration
- [ ] SMS/IVR via Twilio for low-connectivity areas
- [ ] Government scheme linking (static content integration)
- [ ] Pesticide marketplace integration

---

## Key Reminder
MVP priority: **photo → diagnosis → advice** working smoothly beats five half-built features. Judges reward a working core loop over breadth.
