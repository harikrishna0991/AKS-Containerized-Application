param(
    [string]$ImageTag = "1.0"
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$TerraformDir = Join-Path $Root "terraform"
$KubernetesDir = Join-Path $Root "kubernetes"

Push-Location $TerraformDir

$AcrLoginServer = terraform output -raw acr_login_server
$SqlServerFqdn  = terraform output -raw sql_server_fqdn
$SqlDatabase    = terraform output -raw sql_database_name
$AksServiceIp   = terraform output -raw aks_service_private_ip

Pop-Location

if (-not $env:SQL_ADMIN_PASSWORD) {
    throw "Set SQL_ADMIN_PASSWORD in the current PowerShell session before deployment."
}

$ConnectionString = "Server=tcp:$SqlServerFqdn,1433;Initial Catalog=$SqlDatabase;User ID=sqladmin;Password=$env:SQL_ADMIN_PASSWORD;Encrypt=True;TrustServerCertificate=False;"

$SecretTemplate = Get-Content (Join-Path $KubernetesDir "secret.yaml") -Raw
$SecretContent = $SecretTemplate.Replace("__CONNECTION_STRING__", $ConnectionString)

$DeploymentTemplate = Get-Content (Join-Path $KubernetesDir "deployment.yaml") -Raw
$DeploymentContent = $DeploymentTemplate `
    .Replace("__ACR_LOGIN_SERVER__", $AcrLoginServer) `
    .Replace("__IMAGE_TAG__", $ImageTag)

$ServiceTemplate = Get-Content (Join-Path $KubernetesDir "service.yaml") -Raw
$ServiceContent = $ServiceTemplate.Replace("__AKS_SERVICE_PRIVATE_IP__", $AksServiceIp)

$TempSecret = Join-Path $env:TEMP "crud-api-secret.yaml"
$TempDeployment = Join-Path $env:TEMP "crud-api-deployment.yaml"
$TempService = Join-Path $env:TEMP "crud-api-service.yaml"

$SecretContent | Set-Content $TempSecret
$DeploymentContent | Set-Content $TempDeployment
$ServiceContent | Set-Content $TempService

kubectl apply -f (Join-Path $KubernetesDir "namespace.yaml")
kubectl apply -f $TempSecret
kubectl apply -f (Join-Path $KubernetesDir "configmap.yaml")
kubectl apply -f $TempDeployment
kubectl apply -f $TempService

Remove-Item $TempSecret, $TempDeployment, $TempService -Force

kubectl -n crud-api rollout status deployment/crud-api --timeout=300s

kubectl -n crud-api get pods -o wide
kubectl -n crud-api get service crud-api-service

Write-Host ""
Write-Host "Kubernetes deployment completed." -ForegroundColor Green
