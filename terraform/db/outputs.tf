output "resource_group" {
  value       = azurerm_resource_group.main.name
  description = "The resource group."
}

output "database_server_fqdn" {
  value       = module.database.postgresql_flexible_server_database_url
  description = "The FQDN of the PostegreSQL database"
}

output "database_server_name" {
  value       = module.database.postgresql_flexible_server
  description = "The FQDN of the PostegreSQL database"
}

output "database_name" {
  value       = module.database.postgresql_flexible_server_database_name
  description = "The name of the PostegreSQL database"
}

output "database_admin_password" {
  value       = module.database.postgresql_flexible_server_admin_password
  description = "The name of the PostegreSQL database"
  sensitive = true
}

