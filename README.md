# Naukri Profile Auto-Refresh Bot 🚀

An automated Playwright-based bot that keeps your Naukri profile fresh and active. By updating your profile headline periodically, it updates your **"Last Updated"** timestamp so your profile stays at the top of recruiter search results.

---

## Features

- 🔐 **Persistent Browser Sessions**: Log in once interactively (handles 2FA/OTP/Captcha seamlessly); browser context is saved locally in `.naukri-session` and `.naukri-india-session`.
- 🔄 **Smart Profile Refresh**: Toggles trailing period on Resume Headline or re-saves Profile Summary to bump the profile timestamp.
- ⏱️ **Scheduled Execution**: Run automatically on a customizable interval (e.g., every 30 or 60 minutes).
- 🇮🇳 **Multi-Region Support**: Supports both global Naukri and Naukri India (`india:refresh`).

---

## Quick Start Guide

### 1. Initial Login Setup (One-Time)

Run the login command to open Chromium, enter your credentials, and handle any OTP/2FA verification:

```bash
npm run login
```
*or*
```bash
node index.js login
```

Once logged in and redirected to your Naukri profile/dashboard, close the browser window. Your session cookies and login tokens are safely stored in `.naukri-session`.

---

### 2. Check Login Status

Verify that your saved session is valid:

```bash
npm run status
```

---

### 3. Run a Single Profile Refresh

To immediately refresh your profile once:

```bash
npm run refresh
```

If you want to view the browser performing the update:

```bash
node index.js refresh --headed
```

---

### 4. Run Scheduled Auto-Refresh

Keep the bot running in the background to automatically refresh your profile every **60 minutes** (default):

```bash
npm run schedule
```

Custom interval (e.g., every 30 minutes):

```bash
node index.js schedule --interval 30
```

---

## Configuration (`.env`)

You can create a `.env` file (copy from `.env.example`) to customize settings:

```env
# Optional credentials for login auto-fill
NAUKRI_EMAIL=your_email@example.com
NAUKRI_PASSWORD=your_password

# Run browser in headless mode (true/false)
HEADLESS=true

# Refresh interval for scheduled mode (in minutes)
REFRESH_INTERVAL_MINUTES=60
```

---

## Running on Another Machine (Plug & Play)

Yes, you can easily move this project to another machine (Windows, macOS, or Linux). Since browser session tokens are stored locally in the `.naukri-session` folder, you have two options:

### Option A: Transfer with Saved Login Session (Recommended)
If you want to move your existing active login session along with the code so you don't have to log in again on the new machine:
1. Copy the entire project folder **including** the `.naukri-session` folder to the new machine.
2. Ensure **Node.js** is installed on the target machine.
3. Open a terminal in the project directory and install dependencies & Playwright browsers:
   ```bash
   npm install
   npx playwright install chromium
   ```
4. Verify your session status:
   ```bash
   npm run status
   ```

### Option B: Fresh Setup on a New Machine
If you prefer starting fresh:
1. Copy the code files (`naukri.js`, `index.js`, `config.js`, `package.json`, etc.) to the new machine.
2. Install dependencies & Playwright browsers:
   ```bash
   npm install
   npx playwright install chromium
   ```
3. Run the interactive login command to authenticate:
   ```bash
   npm run login
   ```
4. Once logged in, close the browser. Your new `.naukri-session` is now generated and ready for automated refreshes.

---

## Running Automated on GitHub Actions (Free Cloud Cron) ☁️

You can run this bot completely for free in the cloud using **GitHub Actions**, which triggers your script on a schedule (e.g., every 6 hours) without keeping your laptop on.

### Setup Steps:
1. Push your project repository to GitHub.
2. In your GitHub repository, go to **Settings > Secrets and variables > Actions**.
3. Add two repository secrets:
   - `NAUKRI_EMAIL`: Your Naukri account email
   - `NAUKRI_PASSWORD`: Your Naukri account password
4. GitHub Actions will automatically detect the workflow configuration located at `.github/workflows/refresh.yml` and run your profile refresh automatically every **2 hours** (optimal balance for ranking & avoiding bot detection). Note that GitHub Secrets remain 100% private and encrypted even if your repository is public.

---

## Project Structure

```
├── config.js         # Configuration loader
├── naukri.js         # Playwright automation core engine
├── index.js          # CLI commands & scheduler entry point
├── package.json      # Dependencies and npm scripts
└── .naukri-session/  # Local persistent browser session storage
```
