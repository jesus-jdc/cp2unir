# Fichero de configuración de red: vnet y snet

# Virtual Network

resource "azurerm_virtual_network" "vnet" {
    name                = "azunir-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

# subnet

resource "azurerm_subnet" "snet" {
    name                   = "azunir-snet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.vnet.name
    address_prefixes       = ["10.0.1.0/24"]

}

# Network Interface (NIC)

# Esto es para una sola máquina virtual. Ampliar a 3 !!!

resource "azurerm_network_interface" "nic" {
  name                = "azunir-nic"  
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "ipconfig"
    subnet_id                      = azurerm_subnet.snet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.10"
    public_ip_address_id           = azurerm_public_ip.pip.id
  }

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }

}

# Public IP (PIP)

# Esto es para una sola máquina virtual. Ampliar a 3 !!!

resource "azurerm_public_ip" "pip" {
  name                = "azunir-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }

}