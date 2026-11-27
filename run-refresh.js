const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const logDir = path.join(__dirname, 'logs');
if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir, { recursive: true });
}

const logFile = path.join(logDir, 'refresh.log');

function log(message) {
    const timestamp = new Date().toISOString();
    const formattedMessage = `[${timestamp}] ${message}\n`;
    console.log(formattedMessage.trim());
    fs.appendFileSync(logFile, formattedMessage, 'utf8');
}

log('Starting scheduled headed refresh...');

exec('node index.js refresh --headed', { cwd: __dirname }, (error, stdout, stderr) => {
    if (stdout) log(`STDOUT:\n${stdout}`);
    if (stderr) log(`STDERR:\n${stderr}`);
    if (error) {
        log(`ERROR: ${error.message}`);
    } else {
        log('Refresh completed successfully.');
    }
});
