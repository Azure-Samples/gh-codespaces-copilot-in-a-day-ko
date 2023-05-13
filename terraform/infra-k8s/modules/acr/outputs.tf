output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "Container registry resource ID"
}

output "registry_name" {
  value       = azurerm_container_registry.acr.name
  description = "Azure Container Registry name"
}

output "acr_fqdn" {
  value       = azurerm_container_registry.acr.login_server
  description = "ACR FQDN."
}

output "admin_username" {
  value       = azurerm_container_registry.acr.admin_username
  description = "Username of the ACR Admin (admin account needs to be enabled)"
  sensitive   = true
}

output "admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  description = "Password of the ACR Admin (admin account needs to be enabled)"
  sensitive   = true
}