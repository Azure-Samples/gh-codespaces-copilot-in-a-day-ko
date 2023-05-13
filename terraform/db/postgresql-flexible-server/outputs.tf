output "postgresql_flexible_server" {
  value = azurerm_postgresql_flexible_server.default.name
}

output "postgresql_flexible_server_database_name" {
  value = azurerm_postgresql_flexible_server_database.default.name
}

output "postgresql_flexible_server_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.default.administrator_password
}

output "postgresql_flexible_server_database_url" {
  value       = "${azurerm_postgresql_flexible_server.default.fqdn}:5432/${azurerm_postgresql_flexible_server_database.default.name}"
  description = "The PostegreSQL server URL."
}
