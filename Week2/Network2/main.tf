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


resource "azurerm_subnet" "Subnet3" {
  name                 = "sub3"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network-2.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "Subnet4" {
  name                 = "sub4"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network-2.name
  address_prefixes     = ["10.1.3.0/24"]
}

resource "azurerm_network_interface" "Sub3-interface" {
  name                = "Sub3-interface"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal3"
    subnet_id                     = azurerm_subnet.Subnet3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pub-ip2.id
  }
}

resource "azurerm_public_ip" "pub-ip2" {
  name                = "pub-ip2"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "Sub4-interface" {
  name                = "Sub4-interface"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal4"
    subnet_id                     = azurerm_subnet.Subnet4.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "VM3" {
  name                = "example-VM3"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "vm3_admin"
  network_interface_ids = [
    azurerm_network_interface.Sub3-interface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  # os_profile {
#     computer_name  = "vm1"
#     admin_username = "vm1_admin"
    
#   }
#   os_profile_linux_config {
#   }

  admin_password = "Password1234!"
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}