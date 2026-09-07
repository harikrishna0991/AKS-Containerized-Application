output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "aks_subnet_name" {
  value = azurerm_subnet.aks.name
}

output "application_gateway_subnet_id" {
  value = azurerm_subnet.application_gateway.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoint.id
}
