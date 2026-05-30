# Azure Private Confluent Kafka Platform

## Overview

This project demonstrates the design and Infrastructure-as-Code implementation of a private Confluent Cloud Kafka platform running on Azure.

The solution uses Azure PrivateLink to provide private connectivity between AKS workloads and Confluent Cloud Kafka brokers while enforcing authentication and authorization through Kafka Service Accounts, API Keys, and ACLs.

The use case is based on an Energy Platform that processes smart meter telemetry and grid operational events.

---

## Architecture Goals

- Provision Azure infrastructure using Terraform
- Provision Confluent Cloud resources using Terraform
- Restrict Kafka access to private networking only
- Deploy AKS workloads capable of producing and consuming Kafka messages
- Implement least-privilege access controls
- Provide operational observability using Datadog
- Document deployment, validation, and operational procedures

---

## Use Case

### Topic 1: meter-readings

Receives smart meter telemetry.

Example:

```json
{
  "meterId": "MTR-1001",
  "timestamp": "2026-06-01T10:15:00Z",
  "consumptionKwh": 5.8
}
```

### Topic 2: grid-alerts

Receives operational grid events.

Example:

```json
{
  "siteId": "SUBSTATION-10",
  "severity": "HIGH",
  "event": "Voltage Spike"
}
```

---

## Architecture

```text
AKS
  |
Private DNS
  |
Azure Private Endpoint
  |
Azure PrivateLink
  |
Confluent Cloud Kafka
```

---

## Components

### Azure

- Resource Group
- Virtual Network
- AKS Cluster
- NAT Gateway
- Private DNS Zone
- Azure Private Endpoint

### Confluent Cloud

- Environment
- Dedicated Kafka Cluster
- Private Network
- PrivateLink Access

### Kafka Resources

- meter-readings
- grid-alerts

### Security

- Service Account
- API Key
- Kafka ACLs

---

## Repository Structure

```text
azure-confluent-private-kafka-poc
│
├── README.md
│
├── docs
│   ├── architecture.md
│   ├── runtime-flow.md
│   ├── security-model.md
│   ├── observability.md
│   └── verification-runbook.md
│
├── diagrams
│
└── terraform
    │
    ├── providers.tf
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    │
    └── modules
        ├── networking
        ├── aks
        └── confluent
```

---

## Terraform Modules

### networking

Responsible for:

- Resource Group
- VNet
- AKS Subnet
- Private Endpoint Subnet
- NAT Gateway
- Private DNS

### aks

Responsible for:

- AKS Cluster
- Node Pools
- Managed Identity

### confluent

Responsible for:

- Environment
- Private Network
- Kafka Cluster
- Topics
- Service Account
- API Key
- ACLs

---

## Observability

Monitoring is implemented using Datadog.

Key metrics include:

- AKS Node Health
- Pod Restarts
- Kafka Producer Success Rate
- Kafka Consumer Lag
- DNS Resolution Failures
- Private Endpoint Connectivity

---

## Verification

Validation includes:

- AKS Deployment Verification
- DNS Resolution Verification
- Private Endpoint Connectivity Tests
- Kafka Topic Verification
- ACL Verification

---

## Assumptions

Confluent Cloud resources require a valid Confluent Cloud account and API credentials.

Terraform definitions are provided for all Confluent resources. Azure resources can be deployed and validated independently within the lab environment.

---

## Future Enhancements

- Azure Key Vault Integration
- AKS Workload Identity
- GitHub Actions CI/CD
- Datadog Dashboards
- Multi-Region Kafka
- Disaster Recovery
