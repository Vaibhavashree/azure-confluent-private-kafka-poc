variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "aks_subnet_id" {
  description = "AKS Subnet ID"
  type        = string
}

variable "aks_node_count" {
  description = "AKS Node Count"
  type        = number

  default = 1
}

variable "aks_vm_size" {
  description = "AKS VM Size"
  type        = string

  default = "Standard_B2s"
}