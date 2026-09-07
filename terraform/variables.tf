variable "location" {
  description = "Azure region"
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for Azure resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "aks_subnet_address_prefix" {
  description = "AKS subnet CIDR"
  type        = string
}

variable "application_gateway_subnet_address_prefix" {
  description = "Application Gateway subnet CIDR"
  type        = string
}

variable "private_endpoint_subnet_address_prefix" {
  description = "Private Endpoint subnet CIDR"
  type        = string
}

variable "aks_service_private_ip" {
  description = "Static private IP used by the AKS internal LoadBalancer Service"
  type        = string
}

variable "aks_kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
  default     = null
}

variable "aks_system_node_count" {
  description = "Number of system nodes"
  type        = number
  default     = 2
}

variable "aks_user_node_count" {
  description = "Number of user nodes"
  type        = number
  default     = 2
}

variable "aks_vm_size" {
  description = "AKS VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "aks_admin_username" {
  description = "Linux admin username"
  type        = string
  default     = "azureadmin"
}

variable "aks_ssh_public_key" {
  description = "SSH public key for AKS nodes"
  type        = string
}

variable "sql_admin_username" {
  description = "Azure SQL administrator username"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Azure SQL administrator password"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Azure SQL database name"
  type        = string
  default     = "CrudApiDb"
}

variable "sql_sku_name" {
  description = "Azure SQL database SKU"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "Common Azure resource tags"
  type        = map(string)
  default     = {}
}
