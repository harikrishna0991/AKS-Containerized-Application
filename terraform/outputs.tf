output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_id" {
  value = module.networking.vnet_id
}

output "acr_name" {
  value = module.acr.name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "aks_name" {
  value = module.aks.name
}

output "aks_resource_group_name" {
  value = module.resource_group.name
}

output "sql_server_fqdn" {
  value = module.sql.fully_qualified_domain_name
}

output "sql_database_name" {
  value = module.sql.database_name
}

output "aks_service_private_ip" {
  value = var.aks_service_private_ip
}

output "application_gateway_public_ip" {
  value = module.application_gateway.public_ip_address
}
