output "lb_public_ip" {
  value       = azurerm_public_ip.lb.ip_address
  description = "IP público do Load Balancer"
}

output "lb_url" {
  value       = "http://${azurerm_public_ip.lb.fqdn}"
  description = "URL pública do Load Balancer"
}

output "vm01_public_ip" {
  value       = azurerm_public_ip.vm01.ip_address
  description = "IP público da VM01"
}

output "vm01_url" {
  value       = "http://${azurerm_public_ip.vm01.ip_address}"
  description = "URL pública da VM01"
}

output "vm02_public_ip" {
  value       = azurerm_public_ip.vm02.ip_address
  description = "IP público da VM02"
}

output "vm02_url" {
  value       = "http://${azurerm_public_ip.vm02.ip_address}"
  description = "URL pública da VM02"
}