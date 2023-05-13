output "oidc_issuer_url" {
    value = azurerm_kubernetes_cluster.aks.oidc_issuer_url  
}

output "cluster_name" {
    value = azurerm_kubernetes_cluster.aks.name
}

output "cluster_fqdn" {
    value = azurerm_kubernetes_cluster.aks.fqdn
}

output "client_certificate" {
    value     = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_certificate : azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    sensitive = true
}

output "client_key" {
    value     = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_key : azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    sensitive = true
}

output "cluster_ca_certificate" {
    value     = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate : azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
    sensitive = true
}

output "kube_config" {
  description = "kubernetes config to be used by kubectl and other compatible tools"
  value = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config.0 : azurerm_kubernetes_cluster.aks.kube_config.0)
}

output "kube_config_raw" {
  description = "raw kubernetes config to be used by kubectl and other compatible tools"
  sensitive = true
  value = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config_raw : azurerm_kubernetes_cluster.aks.kube_config_raw)
}

output "username" {
  description = "kubernetes username"
  value = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config.0.username : azurerm_kubernetes_cluster.aks.kube_config.0.username)
}

output "password" {
  description = "kubernetes password"
  sensitive = true
  value = (var.rbac.ad_integration ?
  azurerm_kubernetes_cluster.aks.kube_admin_config.0.password : azurerm_kubernetes_cluster.aks.kube_config.0.password)
}

output "kubelet_identity" {
  description = "kubelet identity information"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity.0
}