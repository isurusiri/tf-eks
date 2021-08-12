resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    security_group_ids = var.cluster_security_group_ids
    subnet_ids         = var.cluster_subnet_ids
  }

  depends_on = [
    var.eks_cluster_policy,
    var.eks_service_policy,
  ]
}
