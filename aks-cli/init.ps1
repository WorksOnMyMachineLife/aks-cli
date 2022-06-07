Clear-Host
if (Test-Path -Path Env:AzureTenant) {
    $tenant = Get-ChildItem -Path Env:AzureTenant
    Write-Host "Logging in with tenant $($tenant.value)"
    az login --tenant $tenant.value --use-device-code -o none
} else {
    Write-Host "Logging in without tenant"
    az login --use-device-code -o none
}

Set-Alias aks "$PSScriptRoot/aks.ps1" -Scope Global

aks switch

aks