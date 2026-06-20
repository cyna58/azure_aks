resource "helm_release" "monitoring" {
  name       = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"

  create_namespace = true

  version = "86.3.2" 
  values = [file("${path.module}/values/monitoring.yaml")]

  depends_on = [
    helm_release.external_nginx,
    helm_release.cert_manager
  ]
}