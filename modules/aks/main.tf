# ----------------------------
# Variables
# ----------------------------
variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  description = "Azure location/region"
}

variable "cluster_name" {
  type        = string
  description = "AKS cluster name"
}

variable "node_pool_name" {
  type        = string
  description = "Default node pool name"
  default     = "nodepool1"
}

variable "kubernetes_version" {
  type        = string
  description = "Optional AKS version. Leave empty to use latest."
  default     = ""
}

# ----------------------------
# Data Source: Get Latest AKS Version
# ----------------------------
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}

# ----------------------------
# Generate SSH Key for Nodes
# ----------------------------
resource "tls_private_key" "aks_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ----------------------------
# AKS Cluster
# ----------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  kubernetes_version = var.kubernetes_version != "" ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.resource_group_name}-nrg"

  default_node_pool {
    name                 = var.node_pool_name
    vm_size              = "Standard_DS2_v2"
    type                 = "VirtualMachineScaleSets"
    os_disk_size_gb      = 30
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 3
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = tls_private_key.aks_ssh.public_key_openssh
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "dev"
  }
}

# ----------------------------
# Output SSH Private Key (Optional)
# ----------------------------
output "ssh_private_key_pem" {
  value     = tls_private_key.aks_ssh.private_key_pem
  sensitive = true
}