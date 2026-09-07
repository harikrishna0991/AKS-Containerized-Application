# AKS Containerized Application

End-to-end Azure Kubernetes deployment using:

- .NET 8 CRUD API
- Docker
- Azure Container Registry
- Azure Kubernetes Service
- Kubernetes Deployment
- Kubernetes LoadBalancer Service
- Azure Application Gateway
- Azure SQL Database
- Azure Private Endpoint
- Azure Private DNS
- Terraform modules
- GitHub Actions

## Architecture

Internet
  |
  v
Application Gateway
  |
  v
AKS Internal LoadBalancer
  |
  +-- Pod 1
  +-- Pod 2
  +-- Pod 3
  |
  v
Azure SQL via Private Endpoint

## Terraform

Terraform manages Azure infrastructure.

## Kubernetes

Kubernetes manifests manage the application workloads.

## CI/CD

GitHub Actions will build the image, push it to ACR, provision infrastructure through Terraform, and deploy the Kubernetes workload.
