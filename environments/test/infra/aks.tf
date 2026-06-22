resource "azurerm_kubernetes_cluster" "azure_aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.nauka.location
  resource_group_name = azurerm_resource_group.nauka.name
  dns_prefix          = "test-${var.cluster_name}"

  kubernetes_version        = var.kubernetes_version
  private_cluster_enabled   = false
  node_resource_group       = "${var.resource_group_name}-test-${var.cluster_name}"

  sku_tier = "Free"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.64.10"
    service_cidr   = "10.0.64.0/19"
  }

  default_node_pool {
    name                 = "general"
    vm_size              = "Standard_B2s"
    vnet_subnet_id       = azurerm_subnet.subnet1.id
    type                 = "VirtualMachineScaleSets"
    auto_scaling_enabled  = true
    node_count           = var.node_count
    min_count            = 2
    max_count            = 5

    node_labels = {
      role = "general"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.base.id]
  }

    tags = local.common_tags


  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  depends_on = [
    azurerm_role_assignment.base
  ]

  azure_active_directory_role_based_access_control {
      admin_group_object_ids = [
      azuread_group.aks_admin.object_id
    ]
  }

}