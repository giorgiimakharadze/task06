variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault Id"
}

variable "key_vault_secret_password_name" {
  type        = string
  description = "Name of Key Vault secret for password"
}

variable "key_vault_secret_username_name" {
  type        = string
  description = "Name of Key Vault secret for username"

}

variable "sql_server_name" {
  type        = string
  description = "SQL Server name"
}

variable "sql_server_version" {
  type        = string
  description = "SQL Server version"
}

variable "admin_login" {
  type        = string
  description = "Admin username"
}

variable "minimum_tls_version" {
  type        = string
  description = "Minimum TLS version for server"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled"
}

variable "firewall_rules" {
  type = map(object({
    name     = string
    start_ip = string
    end_ip   = string
  }))

  description = "Firewall Rules for SQL server"
}

variable "sql_database_name" {
  type        = string
  description = "Name of SQL Database"
}

variable "db_sku_name" {
  type        = string
  description = "Database SKU name"
}

variable "db_collation" {
  type        = string
  description = "Database collation"
}

variable "db_max_size_gb" {
  type        = number
  description = "Max database size"
}

variable "db_zone_redundant" {
  type        = bool
  description = "Whether DB is zoer redundant"
}

variable "admin_password_length" {
  type        = number
  description = "Length of generated SQL admin password"
}

variable "admin_password_override_special" {
  type        = string
  description = "Allowed Special character"
}
