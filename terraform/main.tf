# Fichero de configuración que incluye datos del Provider, Service Principal, Resource Group y Storage Account

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
  subscription_id = "609e9b68-b0e5-4a40-b1d1-3f1735109e81"
  client_id       = "5b549e16-047e-418c-902e-4a609c258b2d"
  client_secret   = "7XBLUUo5sibPQCg7lN0aJmyfue4McI.TqI"
  tenant_id       = "899789dc-202f-44b4-8472-a6d40f9eb440"
}

# Datos del Resource Group

resource "azurerm_resource_group" "rg" {
    name     = "azunir-rg"
    location = var.location

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

# Datos del Storage Account

resource "azurerm_storage_account" "sacc" {
    name                     = "azunirsacc27062021" 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}