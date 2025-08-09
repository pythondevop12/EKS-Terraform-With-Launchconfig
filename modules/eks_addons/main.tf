resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = var.eks_cluster_name
  addon_name    = "vpc-cni"
  addon_version = var.vpc_cni_version
  tags = {
    "Environment" = terraform.workspace
  }
}


resource "aws_eks_addon" "coredns" {
  cluster_name = var.eks_cluster_name
  addon_name   = "coredns"

  resolve_conflicts_on_update = "OVERWRITE"
  configuration_values = jsonencode({
    tolerations  = [],
    nodeSelector = {},
    replicaCount = 2,
    resources = {
      limits = {
        cpu    = "100m"
        memory = "150Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "150Mi"
      }
    }
  })


  tags = {
    Environment = terraform.workspace
  }

  depends_on = [
    aws_eks_addon.vpc_cni
  ]
}

