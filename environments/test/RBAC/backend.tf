terraform {
  backend "azurerm" {
    storage_account_name = "michalazureaks155908"
    container_name = "tfstatecontainer"
    key = "rbac.terraform.tfstate"
    resource_group_name = "tfstate_rg"
}
}