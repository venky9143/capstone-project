variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}
variable "zone_names" {
  description = "A list of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

}
variable "vpc_id" {
  description = "The ID of the VPC to deploy resources in"
  type        = string
  default     = "vpc-0d5ba31c971eeaefa"
}
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
variable "eks-cluster-name" {
  description = "The name of the EKS Cluster"
  type        = string
  default     = "capstone-cluster"
}
variable "node_group_name" {
  description = "The name of the EKS Node Group"
  type        = string
  default     = "capstone-node-group"

}
variable "corednsaddon-name" {
  type    = string
  default = "coredns"
}
variable "kubeaddon-name" {
  type    = string
  default = "KubeProxy"

}
variable "vpcaddon-name" {
  type    = string
  default = "Vpccni"

}