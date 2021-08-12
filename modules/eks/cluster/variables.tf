variable "cluster_name" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "cluster_security_group_ids" {
  type = list(string)
}

variable "cluster_subnet_ids" {
  type = list(string)
}

variable "eks_cluster_policy" {
}

variable "eks_service_policy" {
}
