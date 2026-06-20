resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.nauka.location
  resource_group_name = azurerm_resource_group.nauka.name
  
  tags = local.common_tags
  
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.aks_subnet1
  address_prefixes     = ["10.0.0.0/19"]
  resource_group_name  = azurerm_resource_group.nauka.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
}

resource "azurerm_subnet" "subnet2" {
  name                 = var.aks_subnet2
  address_prefixes     = ["10.0.32.0/19"]
  resource_group_name  = azurerm_resource_group.nauka.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
}