resource "kubernetes_cluster_role_v1" "aks_developer" {
  metadata {
    name = "aks-developer-role"
  }

  # PODS / SERVICES / CONFIGMAPS (read-only)
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "events"]
    verbs      = ["get", "list", "watch"]
  }

  # LOGS
  rule {
    api_groups = [""]
    resources  = ["pods/log"]
    verbs      = ["get", "list"]
  }

  # DEPLOYMENTS
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets", "statefulsets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  # JOBS / CRONJOBS
  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "cronjobs"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

# Binding 

resource "kubernetes_cluster_role_binding_v1" "aks_developer_binding" {
  metadata {
    name = "aks-developer-binding"
  }

  subject {
    kind      = "Group"
    name      = data.terraform_remote_state.infra.outputs.aks_developer_object_id
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.aks_developer.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}