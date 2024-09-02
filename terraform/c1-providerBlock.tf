terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

#terraform state storage to azure stroage container
terraform {
  backend "azurerm" {
    resource_group_name   = "TFBackend-CS"
    storage_account_name  = "capstone2580"
    container_name        = "tfstatesfiles"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7fd2d34f-fe5e-4cd6-81fb-d7ef5b32c079"
}
