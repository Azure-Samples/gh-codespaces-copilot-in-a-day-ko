terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.16"
    }
  }
}

resource "azurecaf_name" "aks_cluster" {
  name          = var.application_name
  resource_type = "azurerm_kubernetes_cluster"
  suffixes      = [var.environment]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = azurecaf_name.aks_cluster.result
  resource_group_name = var.resource_group
  location            = var.location
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "defaultpool"
    node_count = var.agent_count
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }


}

# grant permission to aks to pull images from acr
resource "azurerm_role_assignment" "acrpull_role" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}

