data "azurerm_kubernetes_cluster" "azure_aks" {
  name                = data.terraform_remote_state.infra.outputs.aks_name
  resource_group_name = data.terraform_remote_state.infra.outputs.aks_resource_group
}