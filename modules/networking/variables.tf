variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_address_prefix" {
  type = string
}

variable "application_gateway_subnet_address_prefix" {
  type = string
}

variable "private_endpoint_subnet_address_prefix" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
