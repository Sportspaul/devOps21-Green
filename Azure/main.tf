provider "azurerm" {
  features {}
}

backend "remote" {
  organization = "DevOps21_TeamGreen"
  workspaces {
    name = "DevOps21-Green"
  }
}
