resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

locals {
  server_name = "${replace(var.name_prefix, "-", "")}sql${random_string.suffix.result}"
}

resource "azurerm_mssql_server" "this" {
  name                         = local.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name      = var.database_name
  server_id = azurerm_mssql_server.this.id

  sku_name    = var.sku_name
  max_size_gb = 2

  tags = var.tags
}
