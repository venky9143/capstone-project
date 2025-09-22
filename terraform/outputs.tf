output "region" {
  description = "The AWS region where resources are deployed"
  value       = var.region
}
output "zone-names" {
  description = "The availability zones where resources are deployed"
  value       = var.zone_names
}

output "vpc_id" {
  description = "The ID of the VPC where resources are deployed"
  value       = module.vpc.vpc_id
}

output "vpc_subnet_ids" {
  description = "The IDs of the subnets in the VPC"
  value       = module.vpc.subnet_ids
}
# Cluster Role Name
output "EKS_Cluster_Role_name" {
  description = "The name of the EKS Cluster IAM Role"
  value       = module.iam.EKS_Cluster_Role_name
}

# Node Role Name
output "EKS_Node_Role_name" {
  description = "The name of the EKS Node IAM Role"
  value       = module.iam.EKS_Node_Role_name
}

# Cluster Role ARN
output "aws_iam_role_arn" {
  description = "The ARN of the EKS Cluster IAM Role"
  value       = module.iam.aws_iam_role_arn
}

# IAM Policy Attachments Names
output "aws_iam_policy_attachment_name" {
  description = "The name of the IAM policy attachment for cluster"
  value       = module.iam.aws_iam_policy_attachment_name
}

# Cluster Policies ARNs
output "AmazonEKSClusterPolicy_arn" {
  description = "The ARN of the AmazonEKSClusterPolicy"
  value       = module.iam.AmazonEKSClusterPolicy_arn
}

output "AmazonEKSServicePolicy_arn" {
  description = "The ARN of the AmazonEKSServicePolicy"
  value       = module.iam.AmazonEKSServicePolicy_arn
}

# Node Policies ARNs
output "eks_node_ecr_policy_arn" {
  description = "The ARN of the AmazonEC2ContainerRegistryReadOnly policy"
  value       = module.iam.eks_node_ecr_policy_arn
}

output "eks_node_cni_policy_arn" {
  description = "The ARN of the AmazonEKS_CNI_Policy"
  value       = module.iam.eks_node_cni_policy_arn
}

output "eks_node_worker_policy_arn" {
  description = "The ARN of the AmazonEKSWorkerNodePolicy"
  value       = module.iam.eks_node_worker_policy_arn
}


output "eks_cluster_name" {
  description = "The name of the EKS Cluster"
  value       = module.eks.eks_cluster_name
}
output "eks-node-group_name" {
  description = "The name of the EKS Node Group"
  value       = module.eks.eks_node-group_name
}
output "vpcaddon" {
  value = module.addons.vpccni
}

output "kube-proxy" {
  value = module.addons.kube_proxy
}

output "coredns" {
  value = module.addons.coredns
}
