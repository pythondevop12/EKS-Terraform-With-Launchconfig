output "alb_sg_id" {
  value = aws_security_group.ALBSG.id
}

output "ekssg_id" {
  value = aws_security_group.ekssg.id
}

output "eks_cluster_sg" {
  value = aws_security_group.eks_cluster_sg.id
}