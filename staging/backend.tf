terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstagebackend2026rash"
    container_name      = "tfstate"
    key                 = "stage.tfstate"

  }
}

provider "azurerm" {
  features {}
}
