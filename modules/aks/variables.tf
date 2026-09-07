variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "subnet_id" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "system_node_count" {
  type    = number
  default = 2
}

variable "user_node_count" {
  type    = number
  default = 2
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

variable "pod_cidr" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
