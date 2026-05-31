variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet Address Space"
  type        = list(string)

  default = ["10.0.0.0/16"]
}

variable "aks_subnet_address_space" {
  description = "AKS Subnet CIDR"
  type        = list(string)

  default = ["10.0.2.0/24"]
}

variable "private_endpoint_subnet_address_space" {
  description = "Private Endpoint Subnet CIDR"
  type        = list(string)

  default = ["10.0.3.0/24"]
}