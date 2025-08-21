variable "admin_password" {
  description = "Admin password for virtual machines"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.admin_password) >= 8 && can(regex("[A-Z]", var.admin_password)) && can(regex("[a-z]", var.admin_password)) && can(regex("[0-9]", var.admin_password)) && can(regex("[^A-Za-z0-9]", var.admin_password))
    error_message = "Password must be at least 8 characters long and contain uppercase, lowercase, number, and special character."
  }
}