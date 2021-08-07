resource "aws_security_group" "node-sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = var.tags
}

resource "aws_security_group_rule" "node-ingress-self" {
  description              = var.node_ingress_description
  from_port                = var.node_ingress_from_port
  protocol                 = var.node_ingress_protocol
  security_group_id        = aws_security_group.node-sg.id
  source_security_group_id = !var.is_worker ? var.node_ingress_source_sg_id : aws_security_group.node-sg.id
  to_port                  = var.node_ingress_to_port
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-cluster" {
  description              = var.cluster_ingress_description
  from_port                = var.cluster_ingress_from_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node-sg.id
  source_security_group_id = var.is_worker ? aws_security_group.node-sg.id : null
  to_port                  = var.cluster_ingress_to_port
  type                     = "ingress"
}
