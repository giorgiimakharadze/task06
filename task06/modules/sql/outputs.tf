output "sql_server_id" {
  value       = azurerm_mssql_server.sql.id
  description = "Sql Server id"
}

output "sql_server_name" {
  value       = azurerm_mssql_server.sql.name
  description = "Sql Server Name"
}

output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
  description = "Domain name of Sql server"
}

output "sql_database_id" {
  value       = azurerm_mssql_database.sqldb.id
  description = "Sql database id"
}

output "sql_database_name" {
  value       = azurerm_mssql_database.sqldb.name
  description = "Sql database name"
}

output "sql_admin_username_secret_id" {
  value       = azurerm_key_vault_secret.admin_username.id
  description = "Username secret id"
}

output "sql_admin_password_secret_id" {
  value       = azurerm_key_vault_secret.admin_password.id
  description = "Password secret id"
}

output "sql_admin_password" {
  value       = random_password.sql_admin_password.result
  description = "Admin Password"
  sensitive   = true
}

output "sql_connection_string" {
  description = "ADO.NET connection string for Azure SQL Database using SQL authentication."
  sensitive   = true
  value = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.sql.fully_qualified_domain_name,
    azurerm_mssql_database.sqldb.name,
    var.admin_login,
    random_password.sql_admin_password.result
  )
}

