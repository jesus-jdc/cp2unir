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

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}

# Attachment. Ampliar a todas las NIC

resource "azurerm_network_interface_security_group_association" "sg2nic" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.sg.id
}