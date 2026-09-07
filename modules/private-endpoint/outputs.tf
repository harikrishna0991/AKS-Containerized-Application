output "private_endpoint_id" {
  value = azurerm_private_endpoint.sql.id
}

output "private_ip_address" {
  value = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.sql.id
}
