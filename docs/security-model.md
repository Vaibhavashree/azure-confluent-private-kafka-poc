# Security Model

## Security Objectives

The platform is designed around the following principles:

* Private connectivity by default
* Least privilege access
* Encryption in transit
* Infrastructure as Code
* Controlled secret management

---

# Network Security

Kafka access is restricted through Azure PrivateLink.

Traffic path:

```text
AKS
 |
Private Endpoint
 |
PrivateLink
 |
Confluent Kafka
```

No public Kafka endpoints are exposed.

---

# Authentication

Kafka clients authenticate using:

* API Key
* API Secret

Protocol:

```text
SASL_SSL
```

---

# Authorization

Kafka ACLs enforce least privilege.

Granted permissions:

```text
READ meter-readings
WRITE meter-readings

READ grid-alerts
WRITE grid-alerts
```

Consumer group access:

```text
READ Consumer Groups
```

---

# Secret Management

POC Implementation:

* Kubernetes Secrets

Production Recommendation:

* Azure Key Vault
* AKS Workload Identity

---

# Infrastructure Security

Infrastructure is provisioned through Terraform.

Benefits:

* Auditable changes
* Version control
* Repeatability
* Reduced configuration drift

---

# Production Enhancements

Recommended:

* Azure Firewall
* Network Security Groups
* Microsoft Defender for Cloud
* Azure Policy
* Key Rotation Automation