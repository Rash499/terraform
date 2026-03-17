# Datasource to get Latest Azure AKS latest Version
# Check if there is a var with the version name , if not , use the 
# latest version, if there is a var, use that version
# make sure the version specified in var is valid

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

# Generate SSH key for AKS
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Call AKS module
module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  node_pool_name      = var.node_pool_name
  client_id           = var.client_id
  client_secret       = var.client_secret
  ssh_public_key      = tls_private_key.ssh.public_key_openssh
}

# Optional: output private key (sensitive)
output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}

# Output AKS kubeconfig from module
output "aks_kube_config" {
  value = module.aks.config
}