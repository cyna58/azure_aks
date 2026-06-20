resource "helm_release" "poe" {
  name       = "poe-wheel-of-choice"

  repository = "https://cyna58.github.io/helm_charts"
  chart      = "poe-woc"
  version    = "0.1.0"

  namespace        = "poe"
  create_namespace = true

 depends_on = [
    azurerm_kubernetes_cluster.azure_aks,
    azurerm_kubernetes_cluster_node_pool.spot
  ]
}
