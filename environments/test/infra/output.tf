output "aks_name" {
  value = azurerm_kubernetes_cluster.azure_aks.name
}

output "aks_resource_group" {
  value = azurerm_resource_group.nauka.name
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.azure_aks.id
}

output "aks_admin_object_id" {
  value = azuread_group.aks_admin.object_id
}

output "aks_developer_object_id" {
  value = azuread_group.aks_developer.object_id
}