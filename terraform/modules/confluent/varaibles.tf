variable "environment_name" {
  description = "Confluent Environment Name"
  type        = string

  default = "energy-poc-env"
}

variable "kafka_cluster_name" {
  description = "Confluent Kafka Cluster Name"
  type        = string

  default = "energy-poc-cluster"
}

variable "cloud" {
  description = "Cloud Provider"
  type        = string

  default = "AZURE"
}

variable "region" {
  description = "Confluent Region"
  type        = string

  default = "eastus2"
}