module "vpc" {
  source = "./modules/vpc"

  name                         = "vpc-module-demo-x"
  aws_availability_zones_names = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    "Name"                                      = "terraform-eks-dev-node"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}
