output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}
output "node_role_name" {
  value = aws_iam_role.node_role.name
}
output "cluster_role_arn" {
  value = aws_iam_role.eks_role.arn
}
output "cluster_role_name" {
  value = aws_iam_role.eks_role.arn
}

output "eks_admin_arn" {
  value = aws_iam_user.eks_admin.arn
}


