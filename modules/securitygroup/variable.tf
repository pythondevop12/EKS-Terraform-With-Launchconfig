variable "security_group_name" {
  description = "use for security group name value"
  default = "eks-sg"
}

variable "vpc_id" {
    description = "use for the vpc id value"
  
}

variable "ALB_sg_name" {
  description = "alb sg value"
  default = "ALB-SG"
}