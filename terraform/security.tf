# Security groups y asociaciones

resource "azurerm_network_security_group" "sg" {
    name                = "azunir-sg"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "JENKINS"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "30000"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

# Attachment. Aplicamos mismo NSG a toda la subnet

resource "azurerm_subnet_network_security_group_association" "nsg2snet" {
    subnet_id      = azurerm_subnet.snet.id
    network_security_group_id = azurerm_network_security_group.sg.id
}