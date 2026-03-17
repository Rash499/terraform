terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfdevbackend2024piyush"
    container_name      = "tfstate"
    key                 = "dev.tfstate"

    access_key = "SwL+JGwkAAA2kXTQk+g4phDLRzsbiKX4xqgp5V91cEmaiZw6grzkv5u0nfzeqyjGIsIJtR9ASTYu+AStGHgC4A=="

  }
}

provider "azurerm" {
  features {}
}
