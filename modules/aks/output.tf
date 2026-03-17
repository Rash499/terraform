output "config" {
  value = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
}

output "ssh_public_key" {
  value = var.ssh_public_key
}