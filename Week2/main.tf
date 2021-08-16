provider "azurerm" {
  features {}
}

module "rg" {
  source = "./Resource"
}

module "network1" {
  source = "./Network"
}


# module "network2" {
#   source = "./Network/Network2"
#   subnets = {

#   }
# }


# module "vm" {
#   source = "./VM"
# }

