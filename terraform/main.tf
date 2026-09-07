module "resource_group" {
  source = "../modules/resource-group"

  name     = "${var.name_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "networking" {
  source = "../modules/networking"

  name                                      = "${var.name_prefix}-network"
  resource_group_name                       = module.resource_group.name
  location                                  = var.location
  vnet_address_space                        = var.vnet_address_space
  aks_subnet_address_prefix                 = var.aks_subnet_address_prefix
  application_gateway_subnet_address_prefix = var.application_gateway_subnet_address_prefix
  private_endpoint_subnet_address_prefix    = var.private_endpoint_subnet_address_prefix
  tags                                      = local.common_tags
}

module "acr" {
  source = "../modules/acr"

  name_prefix         = var.name_prefix
  resource_group_name = module.resource_group.name
  location            = var.location
  tags                = local.common_tags
}

module "aks" {
  source = "../modules/aks"

  name                = "${var.name_prefix}-aks"
  location            = var.location
  resource_group_name = module.resource_group.name
  dns_prefix          = "${var.name_prefix}-aks"
  kubernetes_version  = var.aks_kubernetes_version
  subnet_id           = module.networking.aks_subnet_id
  vnet_id             = module.networking.vnet_id
  acr_id              = module.acr.id
  system_node_count   = var.aks_system_node_count
  user_node_count     = var.aks_user_node_count
  vm_size             = var.aks_vm_size
  admin_username      = var.aks_admin_username
  ssh_public_key      = var.aks_ssh_public_key
  service_cidr        = "10.100.0.0/16"
  dns_service_ip      = "10.100.0.10"
  pod_cidr            = "10.244.0.0/16"
  tags                = local.common_tags
}

module "sql" {
  source = "../modules/sql"

  name_prefix         = var.name_prefix
  resource_group_name = module.resource_group.name
  location            = var.location
  database_name       = var.sql_database_name
  admin_username      = var.sql_admin_username
  admin_password      = var.sql_admin_password
  sku_name            = var.sql_sku_name
  tags                = local.common_tags
}

module "private_endpoint" {
  source = "../modules/private-endpoint"

  name                      = "${var.name_prefix}-sql-pe"
  resource_group_name       = module.resource_group.name
  location                  = var.location
  subnet_id                 = module.networking.private_endpoint_subnet_id
  vnet_id                   = module.networking.vnet_id
  sql_server_id             = module.sql.server_id
  sql_private_dns_zone_name = "privatelink.database.windows.net"
  tags                      = local.common_tags
}

module "application_gateway" {
  source = "../modules/application-gateway"

  name                = "${var.name_prefix}-appgw"
  resource_group_name = module.resource_group.name
  location            = var.location
  subnet_id           = module.networking.application_gateway_subnet_id
  backend_private_ip  = var.aks_service_private_ip
  backend_port        = 80
  tags                = local.common_tags

  depends_on = [
    module.aks
  ]
}
