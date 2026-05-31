# Observability

## Overview

Datadog provides centralized observability across Azure infrastructure, AKS workloads, and Kafka-connected applications.

---

# AKS Monitoring

Metrics:

* Node CPU
* Node Memory
* Node Disk Utilization
* Pod Restarts
* Container OOM Events
* Cluster Health

---

# Kafka Monitoring

Application metrics:

* Producer Success Rate
* Producer Error Rate
* Consumer Lag
* Message Throughput
* Message Processing Latency

---

# Network Monitoring

Monitor:

* DNS Resolution Failures
* Private Endpoint Reachability
* TLS Handshake Failures
* Connection Timeout Events

---

# Dashboards

Recommended Datadog Dashboards:

## Infrastructure

* AKS Cluster Health
* Node Utilization
* Pod Health

## Kafka

* Producer Throughput
* Consumer Lag
* Error Rate

## Networking

* PrivateLink Connectivity
* DNS Resolution Health

---

# Alerting

## Critical

* Kafka Authentication Failures
* Consumer Lag > 5000
* Private Endpoint Unreachable
* Producer Failure Rate > 10%

## Warning

* Consumer Lag > 1000
* DNS Resolution Failures
* Pod Restart Rate Increase

---

# Log Management

Collect:

* Application Logs
* AKS Logs
* Kafka Client Logs
* Kubernetes Events

Correlate logs with infrastructure metrics for faster incident response.