resource "random_pet" "name_prefix" {
  prefix = var.name_prefix
  length = 1
}

resource "azurerm_virtual_network" "default" {
  name                = "${random_pet.name_prefix.id}-vnet"
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_network_security_group" "default" {
  name                = "${random_pet.name_prefix.id}-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "default" {
  name                 = "${random_pet.name_prefix.id}-subnet"
  virtual_network_name = azurerm_virtual_network.default.name
  resource_group_name  = var.resource_group
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "default" {
  subnet_id                 = azurerm_subnet.default.id
  network_security_group_id = azurerm_network_security_group.default.id
}

resource "azurerm_private_dns_zone" "default" {
  name                = "${random_pet.name_prefix.id}-pdz.postgres.database.azure.com"
  resource_group_name = var.resource_group

  depends_on = [azurerm_subnet_network_security_group_association.default]
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "${random_pet.name_prefix.id}-pdzvnetlink.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = azurerm_virtual_network.default.id
  resource_group_name   = var.resource_group
}

resource "random_password" "pass" {
  length = 20
}

resource "azurerm_postgresql_flexible_server" "default" {
  name                   = "${random_pet.name_prefix.id}-server"
  resource_group_name    = var.resource_group
  location               = var.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.default.id
  private_dns_zone_id    = azurerm_private_dns_zone.default.id
  administrator_login    = "adminTerraform"
  administrator_password = random_password.pass.result
  zone                   = "1"
  storage_mb             = 32768
  sku_name               = "GP_Standard_D2s_v3"
  backup_retention_days  = 7

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}

# This rule is to enable the 'Allow access to Azure services' checkbox
resource "azurerm_postgresql_flexible_server_firewall_rule" "database" {
  name                = "postgresql_flexible_server-fw"
  server_id           = azurerm_postgresql_flexible_server.default.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}