terraform {
  required_version = "~>1.0.0"
  required_providers {
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