resource "aws_eks_node_group" "eks-NG" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.eks_NG
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
  
  launch_template {
    id = var.launch_template_id
    version = "$Latest"

  }
  
  tags = {
    "Name"        = "${terraform.workspace}-eks-node-group"
    "Environment" = "${terraform.workspace}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
  }

}
