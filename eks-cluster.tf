resource "aws_eks_cluster" "dev" {
  name     = var.cluster-name
  role_arn = module.iam_cluster.iam_arn

  vpc_config {
    security_group_ids = [module.sg_cluster.sg_id]
    subnet_ids         = module.vpc_eks.public_subnets
  }

  depends_on = [
    module.iam_cluster.eks_cluster_policy,
    module.iam_cluster.eks_service_policy,
  ]
}
