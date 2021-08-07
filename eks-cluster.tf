resource "aws_eks_cluster" "dev" {
  name     = var.cluster-name
  role_arn = aws_iam_role.dev-cluster.arn

  vpc_config {
    security_group_ids = [module.sg_cluster.sg_id]
    subnet_ids         = module.vpc_eks.public_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.dev-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.dev-cluster-AmazonEKSServicePolicy,
  ]
}
