
variable "node_role_arn" {
  type = string
}

variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)  
  }))
}
