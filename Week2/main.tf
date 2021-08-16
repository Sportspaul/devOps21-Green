provider "azurerm" {
  features {}
}

module "rg" {
  source = "./Resource"
}

module "network1" {
  source        = "./Network1"
  network_name  = "VirtualNetwork1"
  address_space = ["10.0.0.0/16"]
  subnets = {
    "subnet1" = {
      address_space = ["10.0.0.0/24"]
      name          = "sub1"
    }
    "subnet2" = {
      address_space = ["10.0.1.0/24"]
      name          = "sub2"
    }
  }
}
