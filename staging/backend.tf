terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstagebackend2026rash"
    container_name      = "tfstate"
    key                 = "stage.tfstate"
    use_azuread_auth = false
  }
}

provider "azurerm" {
  features {}
}
