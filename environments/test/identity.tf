resource "azurerm_user_assigned_identity" "base" {
  name                = "base"
  location            = azurerm_resource_group.nauka.location
  resource_group_name = azurerm_resource_group.nauka.name
}

resource "azurerm_role_assignment" "base" {
  scope                = azurerm_resource_group.nauka.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
}