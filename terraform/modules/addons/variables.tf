variable "cluster_name" {
  description = "The EKS cluster name"
  type        = string
}

variable "vpc_addon_name" {
  description = "Name of the VPC CNI addon"
  type        = string
}

variable "kube_addon_name" {
  description = "Name of the kube-proxy addon"
  type        = string
}

variable "coredns_addon_name" {
  description = "Name of the CoreDNS addon"
  type        = string
}
