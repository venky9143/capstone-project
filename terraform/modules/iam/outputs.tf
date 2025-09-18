# Cluster IAM Role
output "EKS_Cluster_Role_name" {
  description = "The name of the EKS Cluster IAM Role"
  value       = var.EKS_Cluster_Role_name
}

output "EKS_Node_Role_name" {
  description = "The name of the EKS Node IAM Role"
  value       = var.EKS_Node_Role_name
}

output "aws_iam_role_arn" {
  description = "The ARN of the EKS Cluster IAM Role"
  value       = data.aws_iam_role.EKS-Cluster-Role.arn
}

# Cluster policy attachments
output "aws_iam_policy_attachment_name" {
  description = "The name of the IAM policy attachment"
  value       = aws_iam_policy_attachment.AmazonEKSClusterPolicy.name
}

output "AmazonEKSClusterPolicy_arn" {
  description = "The ARN of the AmazonEKSClusterPolicy"
  value       = aws_iam_policy_attachment.AmazonEKSClusterPolicy.policy_arn
}

output "AmazonEKSServicePolicy_arn" {
  description = "The ARN of the AmazonEKSServicePolicy"
  value       = aws_iam_policy_attachment.AmazonEKSServicePolicy.policy_arn
}

# Node policy attachments
output "eks_node_ecr_policy_arn" {
  description = "The ARN of the AmazonEC2ContainerRegistryReadOnly policy"
  value       = aws_iam_policy_attachment.eks-node-ecr.policy_arn
}

output "eks_node_cni_policy_arn" {
  description = "The ARN of the AmazonEKS_CNI_Policy"
  value       = aws_iam_policy_attachment.eks-node-cni.policy_arn
}

output "eks_node_worker_policy_arn" {
  description = "The ARN of the AmazonEKSWorkerNodePolicy"
  value       = aws_iam_policy_attachment.eks-node-worker.policy_arn
}
output "EKS_Cluster_Role_arn" {
  description = "The ARN of the EKS Cluster IAM Role"
  value       = data.aws_iam_role.EKS-Cluster-Role.arn
}

output "EKS_Node_Role_arn" {
  description = "The ARN of the EKS Node IAM Role"
  value       = data.aws_iam_role.eks-node-role.arn
}
