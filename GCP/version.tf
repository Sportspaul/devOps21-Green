terraform {
  required_version = "~>1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.79.0"
    }
  }
  backend "remote" {
    organization = "DevOps21_TeamGreen"
    workspaces {
      name = "DevOps21-Green"
    }
  }

}