param(
    [Parameter(Mandatory = $true)]
    [string]$AcrName,

    [Parameter(Mandatory = $true)]
    [string]$ImageName,

    [Parameter(Mandatory = $true)]
    [string]$ImageTag
)

$ErrorActionPreference = "Stop"

Write-Host "Getting ACR login server..."

$AcrLoginServer = az acr show `
    --name $AcrName `
    --query loginServer `
    --output tsv

if ([string]::IsNullOrWhiteSpace($AcrLoginServer)) {
    throw "Unable to retrieve ACR login server for '$AcrName'."
}

Write-Host "ACR Login Server: $AcrLoginServer"

Write-Host "Logging in to ACR..."

az acr login --name $AcrName

if ($LASTEXITCODE -ne 0) {
    throw "ACR login failed."
}

$LocalImage = "${ImageName}:${ImageTag}"
$AcrImage = "${AcrLoginServer}/${ImageName}:${ImageTag}"

Write-Host "Tagging image:"
Write-Host "  $LocalImage"
Write-Host "  $AcrImage"

docker tag $LocalImage $AcrImage

if ($LASTEXITCODE -ne 0) {
    throw "Docker tag failed."
}

Write-Host "Pushing image to ACR..."

docker push $AcrImage

if ($LASTEXITCODE -ne 0) {
    throw "Docker push failed."
}

Write-Host "Image successfully pushed to:"
Write-Host "$AcrImage"