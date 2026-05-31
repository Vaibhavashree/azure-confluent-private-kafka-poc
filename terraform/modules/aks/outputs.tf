output "aks_cluster_name" {
  description = "AKS Cluster Name"

  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "AKS Cluster ID"

  value = azurerm_kubernetes_cluster.aks.id
}

output "kubelet_identity" {
  description = "AKS Kubelet Identity"

  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "node_resource_group" {
  description = "AKS Node Resource Group"

  value = azurerm_kubernetes_cluster.aks.node_resource_group
}