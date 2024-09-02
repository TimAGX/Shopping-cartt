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
