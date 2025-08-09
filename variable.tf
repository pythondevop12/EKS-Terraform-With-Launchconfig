variable "cidr_block_val" {
  description = "cidr block value"
  type        = string
}
variable "eks_version" {
  default = "1.33"
}
variable "eks_cluster_name" {
  description = "cluster name suffix value"
}
variable "launch_template" {
  description = "launch template name suffix value"
}



variable "region" {
  type = string
}

variable "instance_type" {
  description = "instance type values"
  type        = string

}
variable "desired_size" {
  description = "numnber of desired node"
}
variable "max_size" {
  description = "numnber of max node"
}
variable "min_size" {
  description = "numnber of min node"
}
variable "eks_NG" {
  description = "eks node group name suffix"
}

variable "public_cidr_block" {
  description = "public ip allow for all value"
}

variable "account_id" {
  type = string
}

