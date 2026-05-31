output "resource_group_name" {
  description = "Resource Group Name"

  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "Resource Group ID"

  value = azurerm_resource_group.rg.id
}

output "vnet_id" {
  description = "Virtual Network ID"

  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual Network Name"

  value = azurerm_virtual_network.vnet.name
}

output "aks_subnet_id" {
  description = "AKS Subnet ID"

  value = azurerm_subnet.aks.id
}

output "private_endpoint_subnet_id" {
  description = "Private Endpoint Subnet ID"

  value = azurerm_subnet.private_endpoint.id
}

output "private_endpoint_id" {
  description = "Confluent Private Endpoint ID"

  value = azurerm_private_endpoint.confluent.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"

  value = azurerm_nat_gateway.nat.id
}

output "private_dns_zone_id" {
  description = "Private DNS Zone ID"

  value = azurerm_private_dns_zone.confluent.id
}

output "private_dns_zone_name" {
  description = "Private DNS Zone Name"

  value = azurerm_private_dns_zone.confluent.name
}