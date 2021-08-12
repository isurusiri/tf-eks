data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon
}

locals {
  node_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${var.cluster_endpoint}' --b64-cluster-ca '${var.cluster_certificate_authority_data}' '${var.cluster_name}'
USERDATA

}

resource "aws_launch_configuration" "eks_node_launch_configuration" {
  associate_public_ip_address = var.is_public_ip_required
  iam_instance_profile        = var.node_iam_instance_profile_name
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = var.node_instance_type
  name_prefix                 = var.node_name_prefix
  security_groups             = var.node_security_groups
  user_data_base64            = base64encode(local.node_userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_node_autoscaling_group" {
  desired_capacity     = var.node_asg_desired_capacity
  launch_configuration = aws_launch_configuration.eks_node_launch_configuration.id
  max_size             = var.node_asg_max_size
  min_size             = var.node_asg_min_size
  name                 = var.node_asg_name
  vpc_zone_identifier  = var.node_vpc_zone

  tag {
    key                 = "Name"
    value               = var.node_asg_name
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
