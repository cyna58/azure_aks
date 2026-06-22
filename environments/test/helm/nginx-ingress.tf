# data "azurerm_kubernetes_cluster" "azure_aks" {
#   name                = var.cluster_name
#   resource_group_name = var.resource_group_name


#   depends_on = [azurerm_kubernetes_cluster.azure_aks]
# }

resource "helm_release" "external_nginx" {
  name = "external"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.8.0"

  values = [file("${path.module}/values/ingress_controller.yaml")]
}