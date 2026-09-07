$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$TerraformDir = Join-Path $Root "terraform"

Push-Location $TerraformDir

terraform fmt -recursive ..
terraform validate
terraform plan

Pop-Location
