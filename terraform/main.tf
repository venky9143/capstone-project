module "vpc" {
  source     = "./modules/vpc"
  vpc_id     = var.vpc_id
  subnet_ids = []
  zone_names = var.zone_names
}

module "iam" {
  source                      = "./modules/iam"
  EKS_Cluster_Role_name       = var.EKS_Cluster_Role_name
  EKS_Node_Role_name          = var.EKS_Node_Role_name
  AmazonEKSClusterPolicy_name = var.AmazonEKSClusterPolicy_name
  AmazonEKSServicePolicy_name = var.AmazonEKSServicePolicy_name
  eks-node-cni_Policy_name    = var.eks-node-cni_Policy_name
  eks-node-ecr_Policy_name    = var.eks-node-ecr_Policy_name
  eks-node-worker_Policy_name = var.eks-node-worker_Policy_name
}

module "eks" {
  source           = "./modules/eks"
  eks-cluster-name = var.eks-cluster-name
  node_group_name  = var.node_group_name
  zone_names       = var.zone_names
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_ids
  cluster_role_arn = module.iam.EKS_Cluster_Role_arn
  node_role_arn    = module.iam.EKS_Node_Role_arn
}

module "addons" {
  source             = "./modules/addons"
  cluster_name       = module.eks.eks_cluster_name
  vpc_addon_name     = "vpc-cni"
  kube_addon_name    = "kube-proxy"
  coredns_addon_name = "coredns"
}
