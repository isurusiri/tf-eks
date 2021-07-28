variable "name" {
  type = string
}

variable "cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "aws_availability_zones_names" {
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  type    = list(string)
}

variable "public_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  type    = list(string)
}

variable "enable_nat_gateway" {
  default = false
  type    = bool
}

variable "enable_vpn_gateway" {
  default = false
  type    = bool
}

variable "tags" {
  type = map(string)
}
