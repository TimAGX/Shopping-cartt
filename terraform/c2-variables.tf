variable "resource_group_location" {
  description = "Where resources will be created"
  type = string
  default = "eastus"
}

variable "resource_group_name" {
  description = "resource group name"
  type = string
  default = "rg"
}

variable "vm_count" {
  description = "number of virtual machine to create"
  default = 2
}

variable "aks_cluster_name" {
  description = "AKS name"
  default = "myAKSCluster"
}

variable "aks_node_count" {
    description = "Number of node in the AKS cluster"
  default = 2
}
