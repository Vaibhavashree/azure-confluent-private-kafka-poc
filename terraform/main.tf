#############################################
# Networking
#############################################

module "networking" {
  source = "./modules/networking"

  resource_group_name = var.resource_group_name
  location            = var.location
}

#############################################
# AKS
#############################################

module "aks" {
  source = "./modules/aks"

  resource_group_name = module.networking.resource_group_name

  location = var.location

  aks_subnet_id = module.networking.aks_subnet_id

  aks_node_count = var.aks_node_count
  aks_vm_size    = var.aks_vm_size
}

#############################################
# Confluent Cloud
#############################################

module "confluent" {
  source = "./modules/confluent"

  environment_name   = "energy-poc-env"
  kafka_cluster_name = "energy-poc-cluster"

  cloud  = "AZURE"
  region = var.location
}