terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.97.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-staticsite-lb-tf"
    storage_account_name = "staticsitelbkbtf002"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
}