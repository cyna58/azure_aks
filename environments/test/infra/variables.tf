variable "resource_group_name" {
    type = string
    description = "Azure RG"
}

variable "location" {
  type = string
  description = "Resources location in Azure"
}

# ============ AKS ============
variable "cluster_name" {
  type = string
  description = "AKS cluster name in Azure"
}

variable "kubernetes_version" {
  type = string
  description = "Kubernetes version"
}

variable "node_count" {
  type = number
  description = "Number of AKS worker nodes"
}

# ============ STORAGE ACCOUNT ============
variable "storage_account_name" {
  type = string
  description = "Name of Azure Storage Account"
}

variable "storage_account_key" {
  type = string
  description = "Name of tfstate file"
}

variable "storage_container_name" {
  type = string
  description = "Container name for Storage Account"
}

variable "tfstate_rescource_group" {
  type = string
  description = "Terraform tfstate RG"
}

# ============ NETWORKING ============
variable "virtual_network_name" {
  type = string
  description = "AKS vnet name"
}

variable "aks_subnet1" {
  type = string
  description = "AKS subnet1"
}

variable "aks_subnet2" {
  type = string
  description = "AKS subnet2"
}

variable "user_principal" {
  type = string
  description = "User principal name"
}