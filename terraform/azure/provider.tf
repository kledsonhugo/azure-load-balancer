terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-staticsite-lb-tf-aluno02"
    storage_account_name = "staticsitelbtfaluno02"
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
    name     = "rg-staticsite-lb-aluno02"
    location = "brazilsouth"
}