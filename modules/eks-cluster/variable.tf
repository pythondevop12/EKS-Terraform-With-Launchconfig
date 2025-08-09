variable "eks_cluster_name" {
  description = "use for eks cluster name value"
  type = string 
}

variable "cluster_role_name" {
  description = "use for role name value"
  type = string 
}
variable "cluster_role_arn" {
  description = "use for role name value"
  type = string 
}

variable "private_subnet_ids" {
  description = "for private subnet ids value"
}

variable "eks_cluster_sg" {
  type = string
}

