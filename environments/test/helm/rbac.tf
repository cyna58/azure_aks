resource "kubernetes_cluster_role" "aks_developer" {
  metadata {
    name = "aks-developer"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log", "services", "configmaps"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch"]
  }
}

resource "kubernetes_cluster_role_binding" "aks_developer" {
  metadata {
    name = "aks-developer-binding"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.aks_developer.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "Group"
    name      = data.terraform_remote_state.infra.outputs.aks_developer_object_id
    api_group = "rbac.authorization.k8s.io"
  }
}