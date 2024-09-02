resource "azurerm_resource_group" "rg" {
  name     = "rg-${random_string.myrandom.id}"
  location = var.resource_group_location
}