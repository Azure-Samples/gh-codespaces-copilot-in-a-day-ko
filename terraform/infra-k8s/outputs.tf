output "resource_group" {
  value       = azurerm_resource_group.main.name
  description = "The resource group."
}

output "acr_name" {
  value       = module.acr.registry_name
  description = "The name of the container registry."
}

output "cluster_name" {
  value       = module.service.cluster_name
  description = "The name of the AKS cluster."
}

output "cluster_fqdn" {
  value       = module.service.cluster_fqdn
  description = "The FQDN of the AKS cluster."
}

output "client_certificate" {
    value     = module.service.client_certificate
    sensitive = true
}

output "client_key" {
    value     = module.service.client_key
    sensitive = true
}

output "cluster_ca_certificate" {
    value     = module.service.cluster_ca_certificate
    sensitive = true
}

output "kube_config" {
  description = "kubernetes config to be used by kubectl and other compatible tools"
  sensitive = true
  value = module.service.kube_config
}

output "kube_config_raw" {
  description = "raw kubernetes config to be used by kubectl and other compatible tools"
  sensitive = true
  value = module.service.kube_config_raw
}

output "username" {
  description = "kubernetes username"
  sensitive = true
  value = module.service.username
}

output "password" {
  description = "kubernetes password"
  sensitive = true
  value = module.service.password
}

output "kubelet_identity" {
  description = "kubelet identity information"
  value       = module.service.kubelet_identity
}

output "acr_fqdn" {
  value       = module.acr.acr_fqdn
}

output "acr_admin_username" {
  description = "Username of the ACR Admin (admin account needs to be enabled)"
  value       = module.acr.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Password of the ACR Admin (admin account needs to be enabled)"
  value       = module.acr.admin_password
  sensitive   = true
}
