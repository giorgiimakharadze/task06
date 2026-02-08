variable "name_prefix" {
  type        = string
  description = "Name prefix/pattern used to generate resource names (e.g. cmaz-2lfxdvp4-mod6)."
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed (e.g. East US)."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
}

variable "allowed_ip_address" {
  type        = string
  description = "Public IPv4 address allowed to access Azure SQL Server. Update to 18.153.146.156 before verification."
}

variable "key_vault" {
  type = object({
    name                = string
    resource_group_name = string

    secret_sql_admin_username_name = string
    secret_sql_admin_password_name = string
  })
  description = "Key Vault"
}

variable "sql" {
  type = object({
    admin_username = string

    server_version                = string
    minimum_tls_version           = string
    public_network_access_enabled = bool

    firewall_rules = map(object({
      name     = string
      start_ip = string
      end_ip   = string
    }))

    db_sku_name       = string
    db_collation      = string
    db_max_size_gb    = number
    db_zone_redundant = bool

    admin_password_length           = number
    admin_password_override_special = string
  })
  description = "For SQL server and database"
}
variable "apps" {
  type = map(object({
    plan = object({
      sku_name     = string
      worker_count = number
      os_type      = string
    })

    app = object({
      dotnet_version                = string
      ip_restriction_default_action = string

      app_allow_ip_rule = list(object({
        name       = string
        ip_address = string
        priority   = number
        action     = optional(string, "Allow")
      }))

      app_allow_tag_rule = list(object({
        name        = string
        service_tag = string
        priority    = number
        action      = optional(string, "Allow")
      }))

      app_settings = map(string)
    })
  }))

  description = "For app and plan"
}
