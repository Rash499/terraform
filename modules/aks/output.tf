output "config" {
    value = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  
}

output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}