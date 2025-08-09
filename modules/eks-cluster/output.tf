output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}


output "eks_cluster_certificate" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}


output "eks_service_cidr" {
  value = aws_eks_cluster.eks_cluster.kubernetes_network_config[0].service_ipv4_cidr
}

