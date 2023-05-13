terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.30.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.16"
    }
    azapi = {
      source = "azure/azapi"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }

  backend "azurerm" {
        resource_group_name  = "rg-terraformstate"
        storage_account_name = "terraformstate25178"
        container_name       = "dbstate"
        key                  = "terraform.tfstate"
  }
}

provider "azapi" {
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}



locals {
  // If an environment is set up (dev, test, prod...), it is used in the application name
  environment = var.environment == "" ? "dev" : var.environment
}

resource "azurecaf_name" "resource_group" {
  name          = var.application_name
  resource_type = "azurerm_resource_group"
  suffixes      = [local.environment]
}

resource "azurerm_resource_group" "main" {
  name     = azurecaf_name.resource_group.result
  location = var.location

  tags = {
    "terraform"        = "true"
    "environment"      = local.environment
    "application-name" = var.application_name
    "nubesgen-version" = "0.13.0"
  }
}

module "database" {
  source           = "./postgresql-flexible-server"
  resource_group   = azurerm_resource_group.main.name
  environment      = local.environment
  location         = var.location
  database_name    = var.database_name
}
