provider "azurerm" {
  features {}
}

module "rg" {
  source = "./Resource"
}

module "network1" {
  source = "./Network1"
}


module "network2" {
  source = "./Network2"
}


# module "vm" {
#   source = "./VM"
# }

