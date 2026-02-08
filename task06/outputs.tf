output "sql_server_fqdn" {
  description = "server fqdn"
  value       = module.sql.sql_server_fqdn
}

output "app_hostname" {
  description = "app hostname"
  value       = module.webapp["app1"].app_default_hostname
}
