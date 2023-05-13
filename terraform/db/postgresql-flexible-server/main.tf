terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.16"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}
resource "azurecaf_name" "postgresql_server" {
  name          = "pg${var.application_name}"
  resource_type = "azurerm_postgresql_server"
  suffixes      = [var.environment]
}

resource "random_password" "password" {
  length           = 32
  special          = true
  override_special = "_%@"
}

resource "azurerm_postgresql_flexible_server" "default" {
  name                   = azurecaf_name.postgresql_server.result
  resource_group_name    = var.resource_group
  location               = var.location
  version                = "13"

  administrator_login    = var.administrator_login
  administrator_password = random_password.password.result

  zone                   = "1"
  storage_mb             = 32768
  sku_name               = "GP_Standard_D2s_v3"

  backup_retention_days  = 7

  tags = {
    "environment"      = var.environment
    "application-name" = var.application_name
  }
}

resource "azurerm_postgresql_flexible_server_database" "default" {
  name                = var.database_name
  server_id           = azurerm_postgresql_flexible_server.default.id
  collation           = "en_US.UTF8"
  charset             = "UTF8"
}

resource "azurecaf_name" "postgresql_firewall_rule" {
  name          = var.application_name
  resource_type = "azurerm_postgresql_firewall_rule"
  suffixes      = [var.environment]
}

# This rule is to enable the 'Allow access to Azure services' checkbox
resource "azurerm_postgresql_flexible_server_firewall_rule" "default" {
  name                = azurecaf_name.postgresql_firewall_rule.result
  server_id           = azurerm_postgresql_flexible_server.default.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurecaf_name" "mysql_firewall_rule_allow_iac_machine" {
  name          = var.application_name
  resource_type = "azurerm_mysql_firewall_rule"
  suffixes      = [var.environment, "iac"]
}

data "azurerm_resource_group" "parent_rg" {
  name = var.resource_group
}

