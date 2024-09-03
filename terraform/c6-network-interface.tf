resource "azurerm_network_interface" "mynic" {
    count = var.vm_count
    name = "nic-${count.index + 1}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
   public_ip_address_id = azurerm_public_ip.mypip[count.index].id
   #public_ip_address_id = null
  }
}