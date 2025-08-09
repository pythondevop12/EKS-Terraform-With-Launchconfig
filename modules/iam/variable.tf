variable "cluster_role_name" {
  description = "Name for the EKS Cluster IAM Role"
  type        = string
  default     = "eks-cluster-role"
}

variable "node_role_name" {
  description = "Name for the EKS Node Group IAM Role"
  type        = string
  default     = "eks-node-role"
}
variable "instance_profile_name" {
  description = "Name for the EKS Node Group IAM Role"
  type        = string
  default     = "dev-instance-profile"
}