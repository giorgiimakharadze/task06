resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault" "existing" {
  name                = var.key_vault.name
  resource_group_name = var.key_vault.resource_group_name
}

module "sql" {
  source = "./modules/sql"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  key_vault_id = data.azurerm_key_vault.existing.id

  key_vault_secret_username_name = var.key_vault.secret_sql_admin_username_name
  key_vault_secret_password_name = var.key_vault.secret_sql_admin_password_name


  sql_server_name   = local.sql_server_name
  sql_database_name = local.sql_db_name
  admin_login       = var.sql.admin_username


  sql_server_version            = var.sql.server_version
  minimum_tls_version           = var.sql.minimum_tls_version
  public_network_access_enabled = var.sql.public_network_access_enabled

  firewall_rules = merge(
    {
      allow_azure_services = {
        name     = "allow-azure-services"
        start_ip = "0.0.0.0"
        end_ip   = "0.0.0.0"
      }
      allow_specific_ip = {
        name     = "allow-verification-ip"
        start_ip = var.allowed_ip_address
        end_ip   = var.allowed_ip_address
      }
    },
    var.sql.firewall_rules
  )


  db_sku_name       = var.sql.db_sku_name
  db_collation      = var.sql.db_collation
  db_max_size_gb    = var.sql.db_max_size_gb
  db_zone_redundant = var.sql.db_zone_redundant


  admin_password_length           = var.sql.admin_password_length
  admin_password_override_special = var.sql.admin_password_override_special
}

module "webapp" {
  source   = "./modules/webapp"
  for_each = var.apps

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags


  plan_name    = local.asp_name
  os_type      = each.value.plan.os_type
  sku_name     = each.value.plan.sku_name
  worker_count = each.value.plan.worker_count


  app_name       = local.app_name
  dotnet_version = each.value.app.dotnet_version
  app_settings   = each.value.app.app_settings

  app_allow_ip_rule             = each.value.app.app_allow_ip_rule
  app_allow_tag_rule            = each.value.app.app_allow_tag_rule
  ip_restriction_default_action = each.value.app.ip_restriction_default_action


  sql_connection_string = module.sql.sql_connection_string
}
