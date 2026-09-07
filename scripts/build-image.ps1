param(
    [string]$ImageTag = "1.0"
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot

Push-Location $Root

docker build `
    -t "crud-api:$ImageTag" `
    -f ".\docker\Dockerfile" `
    .

if ($LASTEXITCODE -ne 0) {
    throw "Docker build failed."
}

Pop-Location

Write-Host "Docker image built successfully: crud-api:$ImageTag" -ForegroundColor Green
