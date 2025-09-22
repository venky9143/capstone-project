output "vpccni" {
  description = "VPC CNI addon"
  value       = aws_eks_addon.vpccni.id
}

output "kube_proxy" {
  description = "Kube-proxy addon"
  value       = aws_eks_addon.kube_proxy.id
}

output "coredns" {
  description = "CoreDNS addon"
  value       = aws_eks_addon.coredns.id
}
