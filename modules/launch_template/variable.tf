variable "launch_template" {
  description = "launch template name value"
}

variable "image_id" {
  description = "use for ami image"
}

variable "instance_type" {
  description = "use for the instance typ"
   type        = string
}
# variable "instance_profile_name" {
#   description = "use for the instance typ"
#    type        = string
# }

variable "security_group_ids" {
  description = "use for the security group ids"
  type = string
}
variable "eks_cluster_name" {
  description = "use for the  cluster name"
  type = string
}

variable "eks_cluster_endpoint" {
  description = "use for the eks endpoint"
  type = string
}



variable "cluster_service_cidr" {
  description = "eks cluster"
  type = string
}



# variable "certificate_pem_indented" {
#   description = <<EOF
# The cluster CA certificate in PEM format, with each line indented two spaces
# so it can be dropped into a YAML block in the user-data template.
# EOF
#   type = string
# }
variable "eks_cluster_certificate" {
  type = string
}

