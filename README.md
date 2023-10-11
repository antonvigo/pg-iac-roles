# Terraform module: grant privileges on database
Module is used for granting privileges for specified roles.

## Usage example
```
module "roles" {
  source = "github.com/antonvigo/pg-iac-roles"

  users = [
    {
      name     = "user1"
      password = ""
      roles    = ["db1_owner"]
    },
    {
      name     = "user2"
      password = "ThePassword123"
      roles    = ["root", "group_monitoring"]
    }
  ]

  vault_creds_path = "creds/vault/path"

  depends_on = [module.last_existing_privileges_module_call]
}
```
* It's strongly recommended to replace input constants with predefined variables containing corresponding values.
* Even if empty list of privilegs is provided all possbile privileges will be granted. Same way for some other variables.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | 1.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | 1.18.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [postgresql_role.custom_user](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.18.0/docs/resources/role) | resource |
| [random_password.custom_user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [vault_generic_secret.user_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_users"></a> [users](#input\_users) | List of users accounts with granted group roles | <pre>list(object({<br>    name     = string<br>    password = string<br>    roles    = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_vault_creds_path"></a> [vault\_creds\_path](#input\_vault\_creds\_path) | Namespace/path in Vault where new credentials will be placed regarding to the current project | `string` | `"creds/vault/path"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_roles"></a> [created\_roles](#output\_created\_roles) | List of created PostgreSQL roles |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->