output "resource_group_name" {
  description = "Resource Group Name"

  value = module.networking.resource_group_name
}

output "vnet_id" {
  description = "Virtual Network ID"

  value = module.networking.vnet_id
}

output "aks_subnet_id" {
  description = "AKS Subnet ID"

  value = module.networking.aks_subnet_id
}

output "private_endpoint_subnet_id" {
  description = "Private Endpoint Subnet ID"

  value = module.networking.private_endpoint_subnet_id
}

output "aks_cluster_name" {
  description = "AKS Cluster Name"

  value = module.aks.aks_cluster_name
}

output "aks_cluster_id" {
  description = "AKS Cluster ID"

  value = module.aks.aks_cluster_id
}

output "kafka_cluster_id" {
  description = "Confluent Kafka Cluster ID"

  value = module.confluent.kafka_cluster_id
}

output "service_account_id" {
  description = "Confluent Service Account ID"

  value = module.confluent.service_account_id
}

output "meter_readings_topic" {
  description = "Meter Readings Topic"

  value = module.confluent.meter_readings_topic
}

output "grid_alerts_topic" {
  description = "Grid Alerts Topic"

  value = module.confluent.grid_alerts_topic
}