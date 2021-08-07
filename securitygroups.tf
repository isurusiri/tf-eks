# worker module

module "sg_worker" {
  source = "./modules/securitygroups"

  name        = "eks-workder-node-sg"
  description = "Security group for all nodes in the cluster."
  vpc_id      = module.vpc_eks.vpc_id

  tags = {
    "Name"                                      = "terraform-eks-dev-node"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }

  node_ingress_description    = "Allow node to communicate with each other"
  node_ingress_source_sg_id   = ""
  cluster_ingress_description = "Allow worker Kubelets and pods to receive communication from the cluster control plane"

  is_worker = true

}

# cluster module

module "sg_cluster" {
  source = "./modules/securitygroups"

  name        = "eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = module.vpc_eks.vpc_id

  tags = {
    Name = "terraform-eks-cluster"
  }

  node_ingress_description    = "Allow pods to communicate with the cluster API server"
  node_ingress_protocol       = "tcp"
  cluster_ingress_description = "Allow pods to communicate withe the cluster API server"
  node_ingress_source_sg_id   = module.sg_worker.sg_id

  is_worker = false

}
