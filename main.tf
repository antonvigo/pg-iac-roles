locals {
  users_map = zipmap(var.users.*.name, var.users)
}

## Generate random password for all users
resource "random_password" "custom_user" {
  for_each = local.users_map

  #length           = 12
  length      = 16
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  special     = false
  #min_special      = 1
  #override_special = "!@$%&_=+<>"
}

## Add new users with specified groups
resource "postgresql_role" "custom_user" {
  for_each = local.users_map

  name     = each.key
  password = each.value.password != "" ? each.value.password : random_password.custom_user[each.key].result
  roles    = each.value.roles

  login               = true
  skip_reassign_owned = false
}

## Save new roles credentials to Vault
resource "vault_generic_secret" "user_token" {
  path = "${var.vault_creds_path}/postgres-etc-roles"

  data_json = jsonencode({
    for user in postgresql_role.custom_user : user.name => user.password
  })
}
