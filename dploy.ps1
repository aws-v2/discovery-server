# Simple PowerShell Deployment Script
# Usage: .\dploy.ps1 v1.0.3

param(
    [Parameter(Mandatory = $true)]
    [string]$Tag
)

# -----------------------------
# Configuration
# -----------------------------
$DOCKER_USERNAME = "qarani"
$DOCKER_REPO     = "aws-prod"
$IMAGE_NAME      = "amcir-discovery"

# -----------------------------
# Validation
# -----------------------------
if ([string]::IsNullOrWhiteSpace($Tag)) {
    Write-Host "❌ Error: No tag provided!" -ForegroundColor Red
    Write-Host "Usage: .\dploy.ps1 <tag>"
    Write-Host "Example: .\dploy.ps1 v1.0.3"
    exit 1
}

# -----------------------------
# Start
# -----------------------------
Write-Host "🚀 Starting deployment..." -ForegroundColor Cyan
Write-Host "Tag: $Tag" -ForegroundColor White
Write-Host ""

# -----------------------------
# Build
# -----------------------------
Write-Host "📦 Building Docker image..." -ForegroundColor Cyan
docker build -t "$IMAGE_NAME:latest" .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker build failed!" -ForegroundColor Red
    exit 1
}

# -----------------------------
# Tag
# -----------------------------
Write-Host "🏷️  Tagging Docker image..." -ForegroundColor Cyan
docker tag "$IMAGE_NAME:latest" "$DOCKER_USERNAME/$DOCKER_REPO:$Tag"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker tag failed!" -ForegroundColor Red
    exit 1
}

# -----------------------------
# Push
# -----------------------------
Write-Host "☁️  Pushing image to Docker Hub..." -ForegroundColor Cyan
docker push "$DOCKER_USERNAME/$DOCKER_REPO:$Tag"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker push failed!" -ForegroundColor Red
    exit 1
}

# -----------------------------
# Done
# -----------------------------
Write-Host ""
Write-Host "✅ Deployment completed successfully!" -ForegroundColor Green
Write-Host "Image: $DOCKER_USERNAME/$DOCKER_REPO:$Tag" -ForegroundColor White
Write-Host ""
