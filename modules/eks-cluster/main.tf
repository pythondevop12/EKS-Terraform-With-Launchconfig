resource "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
  role_arn                = var.cluster_role_arn
  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids = [var.eks_cluster_sg]
  }
  tags = {
    "Name"        = "${terraform.workspace}-EKSCluster"
    "Environment" = "${terraform.workspace}"
  }
}
