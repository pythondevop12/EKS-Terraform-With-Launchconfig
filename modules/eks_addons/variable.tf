variable "eks_cluster_name" {
  type = string
}

variable "vpc_cni_version" {
  type    = string
  default = "v1.20.0-eksbuild.1" # or let it auto-detect by removing it
}
