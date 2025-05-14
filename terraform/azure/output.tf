output "lb_fqdn" {
  value       = "http://${azurerm_public_ip.lb.fqdn}"
  description = "FQDN público do Load Balancer"
}