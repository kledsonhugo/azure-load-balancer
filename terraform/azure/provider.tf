terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-standard-app-tf"
    storage_account_name = "standardapptf"
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
    name     = "rg-standard-app"
    location = "brazilsouth"
}