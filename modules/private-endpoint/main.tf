resource "azurerm_private_dns_zone" "sql" {
  name                = var.sql_private_dns_zone_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                 = "${var.name}-dns-link"
  private_dns_zone_id  = azurerm_private_dns_zone.sql.id
  virtual_network_id   = var.vnet_id
  registration_enabled = false
}

resource "azurerm_private_endpoint" "sql" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.sql_server_id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }

  tags = var.tags
}
