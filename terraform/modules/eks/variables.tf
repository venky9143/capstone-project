variable "eks-cluster-name" {
  description = "The name of the EKS Cluster"
  type        = string
}
variable "node_group_name" {
  description = "The name of the EKS Node Group"
  type        = string
}
variable "vpc_id" {
  description = "The VPC ID where EKS will be deployed"
  type        = string
}
variable "zone_names" {
  description = "A list of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"] 
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS nodes"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS Cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS Nodes"
  type        = string
}
