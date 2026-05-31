#############################################
# Confluent Environment
#############################################

resource "confluent_environment" "env" {

  display_name = var.environment_name
}

#############################################
# Dedicated Kafka Cluster
#############################################

resource "confluent_kafka_cluster" "cluster" {

  display_name = var.kafka_cluster_name

  availability = "SINGLE_ZONE"

  cloud  = var.cloud
  region = var.region

  dedicated {}

  environment {
    id = confluent_environment.env.id
  }
}

#############################################
# Topic - meter-readings
#############################################

resource "confluent_kafka_topic" "meter_readings" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  topic_name = "meter-readings"

  partitions_count = 6

  rest_endpoint = confluent_kafka_cluster.cluster.rest_endpoint
}

#############################################
# Topic - grid-alerts
#############################################

resource "confluent_kafka_topic" "grid_alerts" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  topic_name = "grid-alerts"

  partitions_count = 6

  rest_endpoint = confluent_kafka_cluster.cluster.rest_endpoint
}

#############################################
# Service Account
#############################################

resource "confluent_service_account" "sa" {

  display_name = "sa-energy-platform"

  description = "AKS Kafka Service Account"
}

#############################################
# API Key
#############################################

resource "confluent_api_key" "kafka" {

  display_name = "energy-platform-api-key"

  description = "Kafka API Key"

  owner {
    id = confluent_service_account.sa.id
  }

  managed_resource {
    id = confluent_kafka_cluster.cluster.id

    environment {
      id = confluent_environment.env.id
    }
  }
}

#############################################
# ACL - meter-readings WRITE
#############################################

resource "confluent_kafka_acl" "meter_readings_write" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  resource_type = "TOPIC"

  resource_name = "meter-readings"

  pattern_type = "LITERAL"

  principal = "User:${confluent_service_account.sa.id}"

  operation  = "WRITE"
  permission = "ALLOW"
}

#############################################
# ACL - meter-readings READ
#############################################

resource "confluent_kafka_acl" "meter_readings_read" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  resource_type = "TOPIC"

  resource_name = "meter-readings"

  pattern_type = "LITERAL"

  principal = "User:${confluent_service_account.sa.id}"

  operation  = "READ"
  permission = "ALLOW"
}

#############################################
# ACL - grid-alerts WRITE
#############################################

resource "confluent_kafka_acl" "grid_alerts_write" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  resource_type = "TOPIC"

  resource_name = "grid-alerts"

  pattern_type = "LITERAL"

  principal = "User:${confluent_service_account.sa.id}"

  operation  = "WRITE"
  permission = "ALLOW"
}

#############################################
# ACL - grid-alerts READ
#############################################

resource "confluent_kafka_acl" "grid_alerts_read" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  resource_type = "TOPIC"

  resource_name = "grid-alerts"

  pattern_type = "LITERAL"

  principal = "User:${confluent_service_account.sa.id}"

  operation  = "READ"
  permission = "ALLOW"
}

#############################################
# ACL - Consumer Groups
#############################################

resource "confluent_kafka_acl" "consumer_group" {

  kafka_cluster {
    id = confluent_kafka_cluster.cluster.id
  }

  resource_type = "GROUP"

  resource_name = "*"

  pattern_type = "LITERAL"

  principal = "User:${confluent_service_account.sa.id}"

  operation  = "READ"
  permission = "ALLOW"
}