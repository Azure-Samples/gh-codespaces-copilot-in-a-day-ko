terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.16"
    }
  }
}

resource "azurecaf_name" "acr" {
  name          = var.application_name
  resource_type = "azurerm_container_registry"
  suffixes      = [var.environment]
}

resource "azurerm_container_registry" "acr" {
  name                          = azurecaf_name.acr.result
  resource_group_name           = var.resource_group
  location                      = var.location
  admin_enabled                 = true
  sku                           = "Standard"
  public_network_access_enabled = true
}