# Fichero de configuración de red: vnet y snet

## Virtual Network

resource "azurerm_virtual_network" "vnet" {
    name                = "azunir-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.rg_name

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

## Subnet

resource "azurerm_subnet" "snet" {
    name                   = "azunir-snet"
    resource_group_name    = var.rg_name
    virtual_network_name   = azurerm_virtual_network.vnet.name
    address_prefixes       = ["10.0.1.0/24"]
}

## Public IP (PIP)

### Nodo master

resource "azurerm_public_ip" "pip_master" {
  name                = "azunir-pip-k8s-master"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

### Nodos worker

resource "azurerm_public_ip" "pip_worker" {
  count = var.wk_count
  name                = "azunir-pip-k8s-worker-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

## Network Interface (NIC)

/* Se reserva la dirección 10.0.1.10 para el nodo master y al resto (workers)
   se le asigna secuencialmente a partir de la definida para el master */

resource "azurerm_network_interface" "nic_master" {
  name                = "azunir-nic-k8s-master"  
  location            = var.location
  resource_group_name = var.rg_name

    ip_configuration {
    name                           = "ipconfig"
    subnet_id                      = azurerm_subnet.snet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.10"
    public_ip_address_id           = azurerm_public_ip.pip_master.id
  }

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

resource "azurerm_network_interface" "nic_worker" {
  count               = var.wk_count
  name                = "azunir-nic-k8s-worker-${count.index}"  
  location            = var.location
  resource_group_name = var.rg_name

    ip_configuration {
    name                           = "ipconfig"
    subnet_id                      = azurerm_subnet.snet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.${count.index + 11}"
    public_ip_address_id           = element(azurerm_public_ip.pip_worker.*.id, count.index)
  }

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }

}