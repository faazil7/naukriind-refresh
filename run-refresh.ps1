$dateStr = (Get-Date).ToString("yyyy-MM-dd")
$timeStr = (Get-Date).ToString("HH-mm-ss")

$logDir = "D:\experiments\naukri-refresh\logs\$dateStr"
if (!(Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force }

$logFile = Join-Path $logDir "refresh-$timeStr.log"
$timestamp = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")

Add-Content -Path $logFile -Value "[$timestamp] Starting scheduled refresh..."
try {
    Set-Location "D:\experiments\naukri-refresh"
    $output = & node index.js refresh --headed 2>&1
    Add-Content -Path $logFile -Value $output
    $timestampEnd = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
    Add-Content -Path $logFile -Value "[$timestampEnd] Refresh completed successfully."
} catch {
    $timestampErr = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
    Add-Content -Path $logFile -Value "[$timestampErr] ERROR: $_"
}
