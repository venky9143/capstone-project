resource "aws_eks_addon" "coredns" {
  cluster_name      = var.cluster_name
  addon_name        = var.coredns_addon_name
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = var.cluster_name
  addon_name        = var.kube_addon_name
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "vpccni" {
  cluster_name      = var.cluster_name
  addon_name        = var.vpc_addon_name
  resolve_conflicts_on_update = "OVERWRITE"
}
