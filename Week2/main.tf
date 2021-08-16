provider "azurerm" {
  features {}
}

module "rg" {
    source = "./Resource"
}

module "network" {
    source = "./Network"
}

module "vm" {
    source = "./VM"
}

