terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=4.77.0"
    }

    azuread = {
      source = "hashicorp/azuread"
        version = "=3.8.0"
    }
    }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}