param(
    [ValidateSet("Enable", "Restore")]
    [string]$Action = "Enable"
)

$ErrorActionPreference = "Stop"
$stateDir = Join-Path $PSScriptRoot "..\.device_awake_backup"
$stateFile = Join-Path $stateDir "settings.json"

function Get-Setting([string]$Ns, [string]$Key) {
    $v = adb shell settings get $Ns $Key 2>&1
    return ($v | Out-String).Trim()
}

function Set-AdbShell([string]$Cmd) {
    adb shell $Cmd | Out-Null
}

if ($Action -eq "Enable") {
    New-Item -ItemType Directory -Force -Path $stateDir | Out-Null
    @{
        screen_off_timeout = Get-Setting "system" "screen_off_timeout"
        stay_on_plugged    = Get-Setting "global" "stay_on_while_plugged_in"
        screensaver        = Get-Setting "secure" "screensaver_enabled"
        saved_at           = (Get-Date).ToString("o")
    } | ConvertTo-Json | Set-Content -Path $stateFile -Encoding UTF8

    Set-AdbShell "settings put global stay_on_while_plugged_in 7"
    Set-AdbShell "settings put system screen_off_timeout 2147483647"
    Set-AdbShell "settings put secure screensaver_enabled 0"
    Set-AdbShell "input keyevent KEYCODE_WAKEUP"
    Set-AdbShell "svc power stayon true"
    Write-Host "Device keep-awake enabled (USB plugged in recommended)."
    Write-Host "Backup: $stateFile"
    exit 0
}

if (-not (Test-Path $stateFile)) { Write-Host "No backup."; exit 0 }
$b = Get-Content $stateFile -Raw | ConvertFrom-Json
if ($b.screen_off_timeout -and "$($b.screen_off_timeout)" -ne "null") {
    Set-AdbShell "settings put system screen_off_timeout $($b.screen_off_timeout)"
}
if ($b.stay_on_plugged -and "$($b.stay_on_plugged)" -ne "null") {
    Set-AdbShell "settings put global stay_on_while_plugged_in $($b.stay_on_plugged)"
}
if ($b.screensaver -and "$($b.screensaver)" -ne "null") {
    Set-AdbShell "settings put secure screensaver_enabled $($b.screensaver)"
}
Set-AdbShell "svc power stayon false"
Write-Host "Device settings restored."