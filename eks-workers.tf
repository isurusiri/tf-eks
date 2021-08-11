data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.dev.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon
}

locals {
  dev-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.dev.endpoint}' --b64-cluster-ca '${aws_eks_cluster.dev.certificate_authority[0].data}' '${var.cluster-name}'
USERDATA

}

resource "aws_launch_configuration" "dev" {
  associate_public_ip_address = true
  iam_instance_profile        = module.iam_worker.iam_instance_profile_name
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = "t2.large"
  name_prefix                 = "terraform-eks-dev"
  security_groups             = [module.sg_worker.sg_id]
  user_data_base64            = base64encode(local.dev-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "dev" {
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.dev.id
  max_size             = 2
  min_size             = 1
  name                 = "terraform-eks-dev"
  vpc_zone_identifier  = module.vpc_eks.public_subnets

  tag {
    key                 = "Name"
    value               = "terraform-eks-dev"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
