terraform {
  required_version = "~>1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.71"
    }
    google = {
      source  = "hashicorp/google"
      version = "~>3.79.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.53"
    }
  }
  backend "remote" {
    organization = "DevOps21_TeamGreen"
    workspaces {
      name = "DevOps21-Green"
    }
  }

}