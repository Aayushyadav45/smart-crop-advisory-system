# Project Setup — Detailed Guide

This covers the full setup for Step 1: GitHub repo + shared workspace, with exact actions for each team member.

---

## Part A: GitHub Repo Setup

### A0. Prerequisites (each team member, before anything else)
- [ ] Install Git: check with `git --version` in terminal. If not installed:
  - Windows: download from git-scm.com
  - Mac: `brew install git` (or it comes with Xcode command line tools)
  - Linux: `sudo apt install git`
- [ ] Create a GitHub account if you don't have one (github.com/join)
- [ ] Set your Git identity locally (one-time, per machine):
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your@email.com"
  ```
- [ ] Set up authentication: GitHub no longer accepts password login for git operations. Either:
  - Use **GitHub CLI**: install `gh`, then run `gh auth login` and follow prompts, OR
  - Use a **Personal Access Token**: GitHub → Settings → Developer settings → Personal access tokens → Generate new token (classic) → check "repo" scope → copy the token → use it as your password when git asks

### A1. Create the repository (one person only — the "repo owner")
1. Go to github.com, click the **+** icon top-right → **New repository**
2. Repository name: `crop-disease-detection-sih`
3. Description: one line about the project
4. Visibility: **Private** (switch to public later if you want it visible for submission)
5. Check **"Add a README file"**
6. Under "Add .gitignore," select **Python** from the dropdown
7. Click **Create repository**

### A2. Clone it locally (every team member runs this)
```bash
git clone https://github.com/<repo-owner-username>/crop-disease-detection-sih.git
cd crop-disease-detection-sih
```
If using a Personal Access Token, when prompted for a password, paste the token instead.

### A3. Create the folder structure (repo owner does this once, then pushes)
```bash
mkdir ml backend frontend design data
echo "ML training code, Colab notebooks, model export files go here. Owner: <ML Engineer name>" > ml/README.md
echo "FastAPI server code. Owner: <Backend Dev name>" > backend/README.md
echo "React/Flutter app code. Owner: <Frontend Dev name>" > frontend/README.md
echo "Figma exports, design specs, icon assets. Owner: <Designer name>" > design/README.md
echo "Disease-remedy dataset (JSON/CSV), translations. Owner: <Content person name>" > data/README.md
```

### A4. Update `.gitignore`
Open the `.gitignore` file (already created from the Python template) in any text editor and add these lines at the bottom:
```
# ML
*.h5
*.tflite
*.pt
*.ipynb_checkpoints/
data/raw/
data/PlantVillage/

# Backend
venv/
env/
__pycache__/
.env

# Frontend
node_modules/
build/
dist/
.expo/

# OS
.DS_Store
Thumbs.db
```
**Why this matters:** trained model files and raw datasets can be hundreds of MB to several GB. Committing them makes the repo slow to clone/pull for everyone and can hit GitHub's file size limits. Share those via the Drive folder (Part B) instead, and only commit the code that produces/loads them.

### A5. Commit and push the initial structure
```bash
git add .
git commit -m "Initial project structure with folders"
git push origin main
```

### A6. Add the other 5 team members as collaborators
1. On the repo page, go to **Settings** (tab at top)
2. Left sidebar → **Collaborators**
3. Click **Add people**
4. Type each teammate's GitHub username or email, send invite
5. Each teammate accepts the invite (check email or GitHub notifications)
6. Now everyone can clone and push directly:
   ```bash
   git clone https://github.com/<repo-owner-username>/crop-disease-detection-sih.git
   ```

### A7. Daily workflow for each person
```bash
# Start of work session — get latest changes
git pull origin main

# ... do your work in your folder ...

# Save your work
git add .
git commit -m "Short description of what you did"
git push origin main
```
- Commit often (every meaningful chunk of progress, not just once a day)
- Write commit messages that describe *what changed*, e.g. `"Add MobileNet training script"` not `"update"`
- If `git push` is rejected because someone else pushed first, run `git pull origin main` first, resolve any conflicts, then push again

### A8. Handling merge conflicts (if two people edit the same file)
```bash
git pull origin main
# Git will mark conflicting sections in the file like this:
# <<<<<<< HEAD
# your version
# =======
# their version
# >>>>>>> commit-hash
```
Open the file, manually decide which version (or combination) to keep, delete the `<<<<<<<`, `=======`, `>>>>>>>` markers, then:
```bash
git add <the-file>
git commit -m "Resolve merge conflict"
git push origin main
```
To avoid this entirely for a hackathon: work in separate files/folders as much as possible (which the `/ml`, `/backend`, `/frontend` split already helps with).

### A9. Branching (optional, only if needed)
For a hackathon timeline, everyone committing to `main` directly is usually fine. Only create a branch if two people must edit the exact same file simultaneously:
```bash
git checkout -b feature/your-feature-name
# work, commit, push
git push origin feature/your-feature-name
# then open a Pull Request on GitHub and merge into main
```

---

## Part B: Shared Drive / Notion Setup

### B1. Choose the tool
- **Google Drive** — simplest if your team already uses Gmail/Google accounts, easy file sharing
- **Notion** — better if you want structured pages, checklists, and databases in one place
Pick whichever the team is already comfortable with; don't spend time learning a new tool mid-hackathon.

### B2. Create the shared folder/page structure

**If using Google Drive:**
1. Create a folder: `SIH - Crop Disease Detection`
2. Inside it, create sub-folders:
   - `01_Class_List` — one doc with the finalized crop + disease labels
   - `02_Reference_Screenshots` — Plantix/Kisan Suvidha screenshots
   - `03_Figma` — a doc containing just the Figma share link
   - `04_Colab` — a doc containing just the Colab notebook link
   - `05_Remedy_Content` — drafts before they get finalized into the repo's `/data` folder
   - `06_Meeting_Notes` — one doc, new dated section per sync
3. Share the top folder: click **Share** → add all 5 teammates' emails → set to **Editor**

**If using Notion:**
1. Create a new page: `SIH - Crop Disease Detection`
2. Add these as sub-pages or sections:
   - **Class List** (a simple table: Crop | Disease Class | Notes)
   - **Reference Screenshots** (image gallery)
   - **Links** (pinned Figma + Colab links at the very top)
   - **Remedy Content** (a database: Disease | Symptoms | Remedy (English) | Remedy (Hindi))
   - **Meeting Notes** (a database, one entry per date)
3. Click **Share** → invite all 5 teammates → set permission to **Can edit**

### B3. Fill in the Class List first
Before anyone starts building, fill in the class list table — this is the single source of truth referenced by the ML Engineer's model output, the Content person's remedy keys, and the Frontend's display labels. Example:

| Crop | Disease Class (exact label) | Notes |
|---|---|---|
| Tomato | Tomato___Early_blight | |
| Tomato | Tomato___Late_blight | |
| Tomato | Tomato___healthy | |
| Potato | Potato___Early_blight | |
| Potato | Potato___Late_blight | |
| Potato | Potato___healthy | |

Use the **exact label format** the ML Engineer will use as the model's output class names — copy-paste this table into the model code, the remedy JSON keys, and the frontend later so there's zero mismatch.

### B4. Pin the critical links
- Google Drive: right-click the Figma and Colab link docs → **Add to Starred**
- Notion: use the "Add to Favorites" (star icon) on those pages, or keep them in a pinned callout block at the top of the main page

---

## Part C: Day-1 Checklist (in order)

1. [ ] Team huddle — lock crop(s) + disease class list (30 min)
2. [ ] Repo owner creates GitHub repo, folder structure, `.gitignore`, pushes (15 min)
3. [ ] Repo owner adds all 5 teammates as collaborators (5 min)
4. [ ] Everyone clones the repo locally, confirms they can pull/push (15 min)
5. [ ] Someone creates the shared Drive/Notion space, invites everyone (10 min)
6. [ ] Class list gets typed into the shared space immediately (10 min)
7. [ ] ML Engineer starts downloading PlantVillage dataset in Colab — this is the slowest step, so start it in parallel while others finish setup, don't wait for "everyone to be ready"

Once this checklist is done, every role from Step 2 onward has what they need to start working independently.
