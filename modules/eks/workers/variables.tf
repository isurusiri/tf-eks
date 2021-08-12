variable "cluster_name" {
  type = string
}

variable "is_public_ip_required" {
  default     = true
  type        = bool
  description = "Specify if a public IP association should be made for worker nodes."
}

variable "node_iam_instance_profile_name" {
  type = string
}

variable "node_instance_type" {
  default = "t2.large"
  type    = string
}

variable "node_name_prefix" {
  default = "eks-node"
  type    = string
}

variable "node_security_groups" {
  type = list(string)
}

variable "node_asg_desired_capacity" {
  default = 2
  type    = number
}

variable "node_asg_max_size" {
  default = 2
  type    = number
}

variable "node_asg_min_size" {
  default = 1
  type    = number
}

variable "node_asg_name" {
  type = string
}

variable "node_vpc_zone" {
  type        = list(string)
  description = "Public subnets of the VPC."
}

variable "cluster_version" {

}

variable "cluster_endpoint" {

}

variable "cluster_certificate_authority_data" {

}
