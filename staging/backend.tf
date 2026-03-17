terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstagebackend2024piyush"
    container_name      = "tfstate"
    key                 = "stage.tfstate"

    access_key = "bbkVoKoHobfeWNUEPL1oCxbRTtz89YPWM2bLlt075kSZoyYCcOC59zS8QclEITOST68fPWBDxY6/+AStCYMFpQ=="
  }
}

provider "azurerm" {
  features {}
}