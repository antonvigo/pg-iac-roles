variable "users" {
  type = list(object({
    name     = string
    password = string
    roles    = list(string)
  }))
  description = "List of users accounts with granted group roles"
  default     = []
}

variable "vault_creds_path" {
  type        = string
  description = "Namespace/path in Vault where new credentials will be placed regarding to the current project"
  default     = "creds/vault/path"
}
