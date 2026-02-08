resource "random_password" "sql_admin_password" {
  length           = var.admin_password_length
  special          = true
  override_special = var.admin_password_override_special

  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
}

resource "azurerm_mssql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.admin_login
  administrator_login_password = random_password.sql_admin_password.result

  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}


resource "azurerm_mssql_firewall_rule" "rules" {
  for_each = var.firewall_rules

  name             = each.value.name
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = each.value.start_ip
  end_ip_address   = each.value.end_ip
}


resource "azurerm_mssql_database" "sqldb" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sql.id

  collation      = var.db_collation
  max_size_gb    = var.db_max_size_gb
  sku_name       = var.db_sku_name
  zone_redundant = var.db_zone_redundant

  tags = var.tags
}


resource "azurerm_key_vault_secret" "admin_username" {
  name         = var.key_vault_secret_username_name
  value        = var.admin_login
  key_vault_id = var.key_vault_id
  content_type = "Azure SQL admin username"
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = var.key_vault_secret_password_name
  value        = random_password.sql_admin_password.result
  key_vault_id = var.key_vault_id

  content_type = "Azure SQL admin password"
  tags         = var.tags
}
