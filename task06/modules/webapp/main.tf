resource "azurerm_service_plan" "asp" {
  name = var.plan_name

  resource_group_name = var.resource_group_name

  location = var.location

  os_type  = var.os_type
  sku_name = var.sku_name

  worker_count = var.worker_count

  tags = var.tags
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true

    ip_restriction_default_action = var.ip_restriction_default_action
    application_stack {
      dotnet_version = var.dotnet_version
    }
    dynamic "ip_restriction" {
      for_each = { for r in var.app_allow_ip_rule : r.name => r }
      content {
        name       = ip_restriction.key
        priority   = ip_restriction.value.priority
        action     = try(ip_restriction.value.action, "Allow")
        ip_address = ip_restriction.value.ip_address
      }
    }

    dynamic "ip_restriction" {
      for_each = { for r in var.app_allow_tag_rule : r.name => r }

      content {
        name        = ip_restriction.key
        priority    = ip_restriction.value.priority
        action      = try(ip_restriction.value.action, "Allow")
        service_tag = ip_restriction.value.service_tag
      }
    }
  }

  app_settings = var.app_settings

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  tags = var.tags
}
