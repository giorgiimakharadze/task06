name_prefix = "cmaz-2lfxdvp4-mod6"
location    = "East US"

tags = {
  Creator = "giorgi_makharadze@epam.com"
}

allowed_ip_address = "18.153.146.156"
key_vault = {
  name                = "cmaz-2lfxdvp4-mod6-kv"
  resource_group_name = "cmaz-2lfxdvp4-mod6-kv-rg"

  secret_sql_admin_username_name = "sql-admin-name"
  secret_sql_admin_password_name = "sql-admin-password"
}

sql = {
  admin_username = "sqladminuser"

  server_version                = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true


  firewall_rules = {
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
  }


  db_sku_name       = "S2"
  db_collation      = "SQL_Latin1_General_CP1_CI_AS"
  db_max_size_gb    = 10
  db_zone_redundant = false

  admin_password_length           = 24
  admin_password_override_special = "!@#$%&*()-_=+[]{}<>:?"
}

apps = {
  app1 = {
    plan = {
      sku_name     = "P0v3"
      worker_count = 1
      os_type      = "Linux"
    }

    app = {
      dotnet_version                = "8.0"
      ip_restriction_default_action = "Deny"

      app_allow_ip_rule  = []
      app_allow_tag_rule = []

      app_settings = {}
    }
  }
}
