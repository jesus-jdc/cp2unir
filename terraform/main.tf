# Fichero de configuración que incluye datos del Provider, Service Principal, Resource Group y Storage Account

# Versión

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

# Datos del Service Principal

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Datos del Resource Group

resource "azurerm_resource_group" "rg" {
    name     = var.rg_name
    location = var.location

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

# Datos del Storage Account

resource "azurerm_storage_account" "sacc" {
    name                     = var.storage_account 
    resource_group_name      = var.rg_name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}