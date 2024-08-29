resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

#Virtual Machine

resource "azurerm_linux_virtual_machine" "myvm" {
  count                 = var.vm_count
  name                  = "myVM-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.mynic[count.index].id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
}

#AKS Cluster

resource "azurerm_kubernetes_cluster" "myaks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksdns"

    default_node_pool {
      name = "default"
      node_count = var.aks_node_count
      vm_size = "Standard_DS2_v2"
    }
    identity {
      type = "SystemAssigned"
    }

    network_profile {
      network_plugin = "azure"
    }
    
}
