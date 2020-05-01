resource "aws_security_group" "app" {
  name        = "${var.app_name}-${var.environment}-app"
  description = "Allow traffic from VPC to container"
  vpc_id      = local.vpc
  tags        = local.tags
}

resource "aws_security_group_rule" "ingress_container_port" {
  security_group_id = aws_security_group.app.id
  type              = "ingress"
  from_port         = var.container_port
  to_port           = var.container_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_allow_all" {
  security_group_id = aws_security_group.app.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
