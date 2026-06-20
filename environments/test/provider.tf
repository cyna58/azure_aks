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

provider "azuread" {}

provider "helm" {
  kubernetes = {
    host                   = data.azurerm_kubernetes_cluster.azure_aks.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.azure_aks.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.azure_aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.azure_aks.kube_config.0.cluster_ca_certificate)
  }
}