# worker module
module "iam_worker" {
  source = "./modules/iam"

  iam_role_name = "eks_iam_worker"
  is_worker     = true
}

# cluster module
module "iam_cluster" {
  source = "./modules/iam"

  iam_role_name = "eks_iam_cluster"
  is_worker     = false
}
