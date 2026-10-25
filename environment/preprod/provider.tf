terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.11.0"
    }
  }
}

provider "azurerm" {
    features {
      virtual_machine {
        delete_os_disk_on_deletion = true
      }
    }
}