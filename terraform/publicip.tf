resource "azurerm_public_ip" "mypip" {
    count = 5
  name                = "myPublicIP-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard"
}