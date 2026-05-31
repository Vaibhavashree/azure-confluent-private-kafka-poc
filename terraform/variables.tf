```hcl
variable "resource_group_name" {
  description = "Resource Group Name"

  type = string

  default = "rg-confluent-mgmt-poc"
}

variable "location" {
  description = "Azure Region"

  type = string

  default = "eastus2"
}

variable "aks_node_count" {
  description = "AKS Node Count"

  type = number

  default = 1
}

variable "aks_vm_size" {
  description = "AKS VM Size"

  type = string

  default = "Standard_B2s"
}

variable "confluent_cloud_api_key" {
  type      = string
  sensitive = true
}

variable "confluent_cloud_api_secret" {
  type      = string
  sensitive = true
}