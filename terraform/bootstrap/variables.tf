variable "location" {
  description = "Azure region for Terraform state resources"
  type        = string
}

variable "state_resource_group_name" {
  description = "Resource group used for Terraform state"
  type        = string
  default     = "rg-akscrud-tfstate"
}

variable "storage_account_prefix" {
  description = "Prefix for Terraform state storage account"
  type        = string
  default     = "tfstateakscrud"
}

variable "tags" {
  description = "Tags for Terraform state resources"
  type        = map(string)
  default = {
    Project   = "AKS-Containerized-Application"
    ManagedBy = "Terraform"
    Purpose   = "TerraformState"
  }
}

