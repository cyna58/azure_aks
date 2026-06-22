#GENERAL
resource_group_name = "aks_rg"
location            = "polandcentral"

#AKS
cluster_name        = "my-aks-cluster"
kubernetes_version  = "1.35.5"
node_count   = 2

#Storage Account for tfstate file
tfstate_rescource_group = "tfstate_rg" 
storage_account_name = "michalazureaks155908"
storage_container_name = "tfstatecontainer"
storage_account_key = "test.terraform.tfstate"

#NETWORKING
aks_subnet1 = "subnet1"
aks_subnet2 = "subnet2"
virtual_network_name = "aks-vnet"

#ENTRA ID - for access to AKS via entra ID groups
user_principal = "09e1a6bf-ff0c-47ad-9cd7-9c418b8008b2"