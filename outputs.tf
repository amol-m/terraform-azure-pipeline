output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "web_subnet" {
  value = azurerm_subnet.web.address_prefixes
}

output "app_subnet" {
  value = azurerm_subnet.app.address_prefixes
}