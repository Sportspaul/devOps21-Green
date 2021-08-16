provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.rg-name
}

resource "azurerm_virtual_network" "network-2" {
  name                = "virtualNetwork2"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_network_interface" "Sub1-interface" {
  name                = "Sub1-interface"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.Subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub-ip1.id
  }
}