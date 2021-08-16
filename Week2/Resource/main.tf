provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "PhantomCloud-rg" {
  name     = "PhantomCloud"
  location = "norway east"
}