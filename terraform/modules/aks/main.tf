#############################################
# AKS Cluster
#############################################

resource "azurerm_kubernetes_cluster" "aks" {

  name                = "aks-confluent-poc"

  location            = var.location

  resource_group_name = var.resource_group_name

  dns_prefix = "aks-confluent"

  ###########################################
  # Default Node Pool
  ###########################################

  default_node_pool {

    name = "system"

    node_count = var.aks_node_count

    vm_size = var.aks_vm_size

    vnet_subnet_id = var.aks_subnet_id
  }

  ###########################################
  # Managed Identity
  ###########################################

  identity {
    type = "SystemAssigned"
  }

  ###########################################
  # Azure CNI Networking
  ###########################################

  network_profile {

    network_plugin = "azure"

    network_policy = "azure"

    outbound_type = "loadBalancer"
  }

  tags = {
    Environment = "POC"
    Project     = "Confluent"
    ManagedBy   = "Terraform"
  }
}