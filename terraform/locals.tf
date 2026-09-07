locals {
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = "AKS-Containerized-Application"
      ManagedBy   = "Terraform"
    }
  )
}
