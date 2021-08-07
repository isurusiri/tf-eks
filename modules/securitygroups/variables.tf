
variable "name" {
  type = string
}

variable "description" {
  default = "Cluster security group"
  type    = string
}

variable "vpc_id" {
  type = string
}


variable "egress_from_port" {
  default = 0
  type    = number
}

variable "egress_to_port" {
  default = 0
  type    = number
}

variable "egress_protocol" {
  default = "-1"
  type    = string
}

variable "egress_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type    = list(string)
}

variable "tags" {
  type = map(string)
}

variable "node_ingress_description" {
  type = string
}

variable "node_ingress_from_port" {
  default = 0
  type    = number
}

variable "node_ingress_protocol" {
  default = "-1"
  type    = string
}

variable "node_ingress_to_port" {
  default = 65535
  type    = number
}

variable "cluster_ingress_description" {
  type = string
}

variable "cluster_ingress_from_port" {
  default = 1025
  type    = number
}


variable "node_ingress_source_sg_id" {
  type = string
}

variable "cluster_ingress_to_port" {
  default = 65535
  type    = number
}

variable "is_worker" {
  type = bool
}
