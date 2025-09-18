output "eks_cluster_name" {
  description = "The name of the EKS Cluster"
  value       = aws_eks_cluster.capstone_cluster.name
}
output "eks_node-group_name" {
  description = "The name of the EKS Node Group"
  value       = aws_eks_node_group.eks_nodes.node_group_name
}
output "zone_names" {
  description = "The availability zones where resources are deployed"
  value       = var.zone_names
  
}
