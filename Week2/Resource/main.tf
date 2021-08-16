provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "PhantomCloud-rg" {
  name     = "PhantomCloud1"
  location = "west europe"
}