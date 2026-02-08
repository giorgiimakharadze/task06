output "app_id" {
  value       = azurerm_linux_web_app.app.id
  description = "Web App ID"
}

output "app_name" {
  value       = azurerm_linux_web_app.app.name
  description = "Web App Name"
}

output "plan_id" {
  value       = azurerm_service_plan.asp.id
  description = "App Service Plan id"
}

output "plan_name" {
  value       = azurerm_service_plan.asp.name
  description = "App Service Plan Name"
}

output "plan_location" {
  value       = azurerm_service_plan.asp.location
  description = "App Service Plan Location"
}


output "app_default_hostname" {
  value       = azurerm_linux_web_app.app.default_hostname
  description = "default hostname"
}
