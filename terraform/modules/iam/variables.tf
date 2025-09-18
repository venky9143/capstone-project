variable "EKS_Cluster_Role_name" {
  description = "The name of the EKS Cluster IAM Role"
  type        = string
  default     = "EKS-Cluster-Role"
}
variable "EKS_Node_Role_name" {
  description = "The name of the EKS Node IAM Role"
  type        = string
  default     = "eks-node-role"
}
variable "AmazonEKSClusterPolicy_name" {
  description = "The name of the EKS Cluster"
  type        = string
  default     = "AmazonEKSClusterPolicy "
}
variable "AmazonEKSServicePolicy_name" {
  description = "The name of the EKS Service Policy"
  type        = string
  default     = "AmazonEKSServicePolicy"

}
variable "eks-node-worker_Policy_name" {
  description = "The name of the EKS Worker Node Policy"
  type        = string
  default     = "AmazonEKSWorkerNodePolicy"
}
variable "eks-node-ecr_Policy_name" {
  description = "The name of the EKS Node ECR Policy"
  type        = string
  default     = "eks-node-ecr"

}
variable "eks-node-cni_Policy_name" {
  description = "The name of the EKS Node CNI Policy"
  type        = string
  default     = "eks-node-cni"
}