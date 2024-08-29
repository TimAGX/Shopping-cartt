# outputs.tf
output "vm_public_ips" {
  value = azurerm_linux_virtual_machine.myvm[*].public_ip_address
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.myaks.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
