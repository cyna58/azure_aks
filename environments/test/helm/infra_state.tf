data "terraform_remote_state" "infra" {
  backend = "azurerm"

  config = {
    resource_group_name  = "tfstate_rg"
    storage_account_name = "michalazureaks155908"
    container_name       = "tfstatecontainer"
    key                  = "infra_test.terraform.tfstate"
  }
}