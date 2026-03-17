terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfdevbackend2026rash"
    container_name      = "tfstate"
    key                 = "dev.tfstate"
    use_azuread_auth = false

  }
}

provider "azurerm" {
  features {}
}
