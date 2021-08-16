provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.rg-name
}

resource "azurerm_virtual_network" "network-1" {
  name                = "virtualNetwork1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "Subnet1" {
  name                 = "sub1"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network-1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "Subnet2" {
  name                 = "sub2"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network-1.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "Sub1-interface" {
  name                = "Sub1-interface"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.Subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "Sub2-interface" {
  name                = "Sub2-interface"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal2"
    subnet_id                     = azurerm_subnet.Subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "VM1" {
  name                = "example-VM1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.Sub1-interface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}