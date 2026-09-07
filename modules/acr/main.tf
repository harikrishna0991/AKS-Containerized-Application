resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

locals {
  acr_name = "${replace(var.name_prefix, "-", "")}${random_string.suffix.result}"
}

resource "azurerm_container_registry" "this" {
  name                = local.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.tags
}
