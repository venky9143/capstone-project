data "aws_iam_role" "EKS-Cluster-Role" {
  name = var.EKS_Cluster_Role_name
}
data "aws_iam_role" "eks-node-role" {
  name = var.EKS_Node_Role_name
}
resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy" {
  name       = var.AmazonEKSClusterPolicy_name
  roles      = [data.aws_iam_role.EKS-Cluster-Role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_iam_policy_attachment" "AmazonEKSServicePolicy" {
  name       = var.AmazonEKSServicePolicy_name
  roles      = [data.aws_iam_role.EKS-Cluster-Role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"

}
resource "aws_iam_policy_attachment" "eks-node-ecr" {
  name       = var.EKS_Node_Role_name
  roles      = [data.aws_iam_role.eks-node-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}
resource "aws_iam_policy_attachment" "eks-node-cni" {
  name       = var.eks-node-ecr_Policy_name
  roles      = [data.aws_iam_role.eks-node-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}
resource "aws_iam_policy_attachment" "eks-node-worker" {
  name       = var.eks-node-worker_Policy_name
  roles      = [data.aws_iam_role.eks-node-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}