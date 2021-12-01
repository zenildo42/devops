resource "aws_security_group" "sg_teste" {
  name        = "allow_teste"
  description = "Allow 22, 80, 443 e icmp inbound traffic"
  vpc_id = aws_vpc.VPC_teste.id
tags = {
    Name = "allow_teste"
}
}

resource "aws_security_group_rule" "sg_rl_teste_ing" {
  count  = length(var.ports)
  type              = "ingress"
  from_port         = "${element(var.ports, count.index)}"
  to_port           = "${element(var.ports, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = [var.ips_liberados[0]]
  security_group_id = aws_security_group.sg_teste.id
}
resource "aws_security_group_rule" "sg_rl_teste_ing2" {
  type              = "ingress"
  from_port         = 8
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.ips_liberados[0]]
  security_group_id = aws_security_group.sg_teste.id
}

resource "aws_security_group_rule" "sg_rl_teste_eg" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.egressCIDRblock[0]]
  security_group_id = aws_security_group.sg_teste.id
}