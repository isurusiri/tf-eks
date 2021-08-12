# cluster
module "eks_cluster" {
  source                     = "./modules/eks/cluster"
  cluster_name               = var.cluster-name
  cluster_role_arn           = module.iam_cluster.iam_arn
  cluster_security_group_ids = [module.sg_cluster.sg_id]
  cluster_subnet_ids         = module.vpc_eks.public_subnets
  eks_cluster_policy         = module.iam_cluster.eks_cluster_policy
  eks_service_policy         = module.iam_cluster.eks_service_policy
}

# workers
module "eks" {
  source                         = "./modules/eks/workers"
  cluster_name                   = var.cluster-name
  node_iam_instance_profile_name = module.iam_worker.iam_instance_profile_name
  node_security_groups           = [module.sg_worker.sg_id]
  node_asg_name                  = "eks_node_asg"
  node_vpc_zone                  = module.vpc_eks.public_subnets

  cluster_version                    = module.eks_cluster.cluster_version
  cluster_endpoint                   = module.eks_cluster.cluster_endpoint
  cluster_certificate_authority_data = module.eks_cluster.cluster_certificate_authority_data
}
