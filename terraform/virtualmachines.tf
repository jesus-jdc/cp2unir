# Configuración de las Máquinas Virtuales.

/* Esta configuración está diseñada para el depliegue de un entorno de kubernetes formado por:
- x 1 Nodo Master/NFS (combina ambos roles)
- x n Nodos Worker (definido por la variable wk_count) 
*/

# Nodo Master/NFS

resource "azurerm_linux_virtual_machine" "vm_master" {
    name                = "azunir-vm-k8s-master-nfs"
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.mt_vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [azurerm_network_interface.nic_master.id]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
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
        role = "master"
    }
}

# Nodos Worker

resource "azurerm_linux_virtual_machine" "vm_worker" {
    count = var.wk_count
    name                = "azunir-vm-k8s-wk-${count.index}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.wk_vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [element(azurerm_network_interface.nic_worker.*.id, count.index)]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
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
        role = "worker"
    }
}