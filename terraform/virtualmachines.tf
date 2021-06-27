# Configuración de las Máquinas Virtuales. Crea una sola. Ampliar a 3!!!

resource "azurerm_linux_virtual_machine" "vm" {
    name                = "azunir-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.vm_size #Definir de forma local según el rol (worker, master...)
    admin_username      = "admin"
    network_interface_ids = [azurerm_network_interface.nic.id]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "admin"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.sacc.primary_blob_endpoint
    }

    tags = {
        project = "unircp2"
        groupId = "azunir"
    }
}