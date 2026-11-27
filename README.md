# Naukri Profile Auto-Refresh Bot 🚀

An automated Playwright-based bot that keeps your Naukri profile fresh and active. By updating your profile headline periodically, it updates your **"Last Updated"** timestamp so your profile stays at the top of recruiter search results.

---

## Features

- 🔐 **Persistent Browser Sessions**: Log in once interactively (handles 2FA/OTP/Captcha seamlessly); browser context is saved locally in `.naukri-session` and `.naukri-india-session`.
- 🔄 **Smart Profile Refresh**: Toggles trailing period on Resume Headline or re-saves Profile Summary to bump the profile timestamp.
- ⏱️ **Scheduled Execution**: Run automatically on a customizable interval (e.g., every 30 or 60 minutes).
- 🇮🇳 **Multi-Region Support**: Supports both global Naukri and Naukri India (`india:refresh`).

---

## Quick Start Guide (Cloning & Running)

If you have just cloned the repository from GitHub, follow these exact steps to run it on your local machine:

### 1. Prerequisites
Ensure you have **Node.js** installed on your system.

### 2. Clone and Install Dependencies
```bash
git clone <YOUR_REPOSITORY_URL>
cd naukri-refresh
npm install
npx playwright install chromium
```

### 3. Authenticate (One-Time Login)
Since browser session folders (`.naukri-session`) are gitignored for security, you need to log in once so the bot can save your session tokens locally:
```bash
npm run login
```
*A browser window will open. Log into your Naukri account manually (handling any OTP or CAPTCHA). Once you are successfully logged in and on your profile/dashboard, close the browser window.*

*(Alternatively, if you already have an existing `.naukri-session` folder from another setup, you can simply paste it directly into the project root directory to skip logging in).*

### 4. Run the Bot
- **Test Refresh**:
  ```bash
  npm run refresh
  ```
- **Run Scheduled Auto-Refresh**:
  ```bash
  npm run schedule
  ```
- **Check Login Status**:
  ```bash
  npm run status
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

## Automated Scheduling (Cron & PM2)

You can schedule the bot to run automatically in the background using either **Linux/macOS Cron** or **PM2 process manager**.

### 1. Using Linux/macOS Cron (`crontab`)
To run the refresh script automatically (e.g., every 2 hours):

1. Open your crontab editor:
   ```bash
   crontab -e
   ```
2. Add the following cron entry (replace `/path/to/naukri-refresh` with your absolute project path and `node` with your absolute Node.js binary path if needed):
   ```cron
   0 */2 * * * cd /path/to/naukri-refresh && /usr/bin/node index.js refresh >> /path/to/naukri-refresh/logs/refresh.log 2>&1
   ```
3. Save and close the editor.

### 2. Using PM2 (Persistent Background Process)
If you prefer running a continuous background loop using built-in node scheduling:
1. Install PM2 globally:
   ```bash
   npm install -g pm2
   ```
2. Start the scheduled script with PM2:
   ```bash
   pm2 start index.js --name "naukri-refresh" -- schedule
   ```
3. Save the PM2 process list so it restarts automatically on system reboots:
   ```bash
   pm2 startup
   pm2 save
   ```

---

## Project Structure

```
├── config.js         # Configuration loader
├── naukri.js         # Playwright automation core engine
├── index.js          # CLI commands & scheduler entry point
├── package.json      # Dependencies and npm scripts
└── .naukri-session/  # Local persistent browser session storage
```
