$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$TerraformDir = Join-Path $Root "terraform"

Push-Location $TerraformDir

terraform apply

Pop-Location
