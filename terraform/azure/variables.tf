variable "key_vault_name" {
  description = "Name of the Azure Key Vault containing the admin password (recommended)"
  type        = string
  default     = null
}

variable "key_vault_resource_group_name" {
  description = "Resource group name of the Azure Key Vault"
  type        = string
  default     = null
}

variable "key_vault_secret_name" {
  description = "Name of the secret in Key Vault containing the admin password"
  type        = string
  default     = "vm-admin-password"
}

variable "admin_password" {
  description = "Admin password for virtual machines (fallback if Key Vault is not used)"
  type        = string
  sensitive   = true
  default     = null

  validation {
    condition     = var.admin_password == null || length(var.admin_password) >= 8
    error_message = "Admin password must be at least 8 characters long."
  }
}