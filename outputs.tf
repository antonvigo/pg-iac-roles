output "created_roles" {
  description = "List of created PostgreSQL roles"
  value       = { for user in postgresql_role.custom_user : user.name => user.password }
}
