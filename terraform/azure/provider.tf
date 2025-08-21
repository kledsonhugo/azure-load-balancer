terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.28.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-appstaticsitelbtf"
    storage_account_name = "azureloadbalancertf"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-appstaticsitelb"
  location = "eastus2"
}