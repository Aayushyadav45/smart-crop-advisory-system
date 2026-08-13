# Where to Put What — Folder Guide

This is the map for the whole project. Read this before adding any file.

---

## `/ml` — ML Engineer's folder
Put here:
- `train_model.ipynb` — your Colab notebook (or a link to it in `ml/colab_link.txt` if the file is too heavy to commit)
- `class_labels.json` — the exact list of disease classes your model outputs (must match `/data/remedies.json` keys exactly)
- `model_export/` — a sub-folder for the final exported model (`.h5` or `.tflite`) — **do not commit the raw dataset here**, it's too large; keep it in Google Drive and just put the Drive link in a text file
- `requirements.txt` — Python packages used (tensorflow, numpy, etc.)

**Do NOT put here:** the raw PlantVillage dataset itself, backend code, frontend code.

---

## `/backend` — Backend Dev's folder
Put here:
- `main.py` — your FastAPI app (the `/predict` endpoint)
- `model_loader.py` — code that loads the ML model exported by the ML Engineer
- `requirements.txt` — Python packages used (fastapi, uvicorn, etc.)
- `Dockerfile` — if you containerize it
- `.env.example` — a template showing what environment variables are needed (API keys etc.) — never commit the real `.env` with actual secrets

**Do NOT put here:** frontend code, the actual model training code (that's `/ml`'s job — you just receive the exported model file).

---

## `/frontend` — Frontend Dev's folder
Put here:
- Your full React or Flutter project (created via `npx create-react-app` or `flutter create`)
- `src/` — your components, screens, API-calling logic
- `assets/` — icons/images pulled from the Designer's Figma exports

**Do NOT put here:** backend server code, ML training code.

---

## `/design` — Designer's folder
Put here:
- `figma_link.txt` — the actual Figma file link (always keep this updated to the latest version)
- `exports/` — exported icons, images, logos as PNG/SVG for the Frontend Dev to use directly
- `style_guide.md` — colors, fonts, spacing rules, so Frontend Dev matches the design exactly

**Do NOT put here:** actual app code — this folder is for design assets and specs only.

---

## `/data` — Content/Data person's folder
Put here:
- `remedies.json` (or `.csv`) — the disease → remedy database. **Keys must exactly match the ML model's class labels** in `ml/class_labels.json`
- `remedies_hindi.json` — translated version
- `sources.md` — where each remedy came from (ICAR, KVK, state agri dept — so it's traceable and verifiable)

**Do NOT put here:** the raw image dataset (that belongs in `/ml`, or better, only in Drive).

---

## `/docs` — Presentation, guides, and planning material
Put here:
- `presentation-script.md` — the script for Milani & Paras
- `github-workspace-setup-guide.md` — the Git/GitHub setup steps
- `crop-disease-detection-roadmap.md` — the full step-by-step build roadmap
- `meeting-notes.md` — dated notes from each team sync
- `class-list.md` — the finalized crop + disease class list (source of truth — reference this from `/ml` and `/data` instead of duplicating it)

---

## Quick Rule of Thumb
If you're not sure where a file goes, ask: **"Whose job produced this file?"**
- ML Engineer produced it → `/ml`
- Backend Dev produced it → `/backend`
- Frontend Dev produced it → `/frontend`
- Designer produced it → `/design`
- Content person produced it → `/data`
- It's about planning, presenting, or documenting → `/docs`

## What NEVER goes into the repo at all (keep in Drive instead)
- Raw PlantVillage dataset (too large)
- Trained model checkpoints beyond the final export (too large)
- `.env` files with real API keys/secrets
- `node_modules/`, `venv/` (regenerated locally, never committed — already in `.gitignore`)
