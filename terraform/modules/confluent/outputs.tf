output "environment_id" {
  description = "Confluent Environment ID"

  value = confluent_environment.env.id
}

output "kafka_cluster_id" {
  description = "Kafka Cluster ID"

  value = confluent_kafka_cluster.cluster.id
}

output "service_account_id" {
  description = "Service Account ID"

  value = confluent_service_account.sa.id
}

output "api_key_id" {
  description = "Kafka API Key ID"

  value = confluent_api_key.kafka.id
}

output "meter_readings_topic" {
  description = "Meter Readings Topic"

  value = confluent_kafka_topic.meter_readings.topic_name
}

output "grid_alerts_topic" {
  description = "Grid Alerts Topic"

  value = confluent_kafka_topic.grid_alerts.topic_name
}