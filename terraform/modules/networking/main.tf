#############################################
# Resource Group
#############################################

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "POC"
    Project     = "Confluent"
    ManagedBy   = "Terraform"
  }
}

#############################################
# Virtual Network
#############################################

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-confluent-mgmt-poc"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  address_space = var.vnet_address_space

  tags = {
    Environment = "POC"
    Project     = "Confluent"
    ManagedBy   = "Terraform"
  }
}

#############################################
# AKS Subnet
#############################################

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = var.aks_subnet_address_space
}

#############################################
# Private Endpoint Subnet
#############################################

resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-private-endpoint"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = var.private_endpoint_subnet_address_space

  private_endpoint_network_policies = "Disabled"
}

#############################################
# Confluent Private Endpoint
#############################################

resource "azurerm_private_endpoint" "confluent" {

  name                = "pep-confluent-kafka"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet_id = azurerm_subnet.private_endpoint.id

  private_service_connection {

    name = "psc-confluent"

    is_manual_connection = false

    private_connection_resource_alias = var.confluent_service_alias
  }

  tags = {
    Environment = "POC"
    Project     = "Confluent"
    ManagedBy   = "Terraform"
  }
}

#############################################
# NAT Gateway Public IP
#############################################

resource "azurerm_public_ip" "nat" {
  name                = "pip-nat-confluent-poc"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
}

#############################################
# NAT Gateway
#############################################

resource "azurerm_nat_gateway" "nat" {
  name                = "nat-confluent-poc"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "Standard"
}

#############################################
# NAT Gateway Association
#############################################

resource "azurerm_nat_gateway_public_ip_association" "nat" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "aks" {
  subnet_id      = azurerm_subnet.aks.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

#############################################
# Private DNS Zone
#############################################

resource "azurerm_private_dns_zone" "confluent" {
  name                = "privatelink.confluent.cloud"
  resource_group_name = azurerm_resource_group.rg.name
}

#############################################
# DNS Zone Link
#############################################

resource "azurerm_private_dns_zone_virtual_network_link" "confluent" {
  name                  = "confluent-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.confluent.name

  virtual_network_id = azurerm_virtual_network.vnet.id
}