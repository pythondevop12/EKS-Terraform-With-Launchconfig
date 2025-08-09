variable "eks_cluster_name" {
  description  = "value of eks cluster name"
  type = string
}
variable "eks_NG"{
  description  = "value of eks cluster name"
  type = string
}
variable "node_role_arn"{
  description  = "value of node group role arn"
  type = string
}
variable "private_subnet_ids"{
  description  = "value of private subnet ids"
  type = list(string)
}

variable "launch_template_id" {
  description = "use for the launch template id"
}

variable "launch_template_version" {
  description = "use for the launch template version"
}

variable "desired_size" {
    description = "no of desired node value"
    type = number
}
variable "min_size" {
    description = "no of minimum number node value"
    type = number
}
variable "max_size" {
    description = "no of max number value"
    type = number
}
