variable "vpc_id" {
  description = "aws vpc id value"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block value"
}

variable "availability_zones" {
  description = "used for azs value"
  type = list(string)  
}
variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}
