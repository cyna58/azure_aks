resource "azuread_group" "aks_admin" {
  display_name     = "aks-admin"
  security_enabled = true
}

resource "azuread_group" "aks_developer" {
  display_name     = "aks-developer"
  security_enabled = true
}

data "azuread_user" "me" {
  object_id = var.user_principal
}

resource "azuread_group_member" "aks_admin_me" {
  group_object_id  = azuread_group.aks_admin.object_id
  member_object_id = data.azuread_user.me.object_id
}
