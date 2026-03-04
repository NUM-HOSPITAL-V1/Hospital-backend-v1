resource "aws_security_group" "control" {
  name        = var.security_group_name
  description = coalesce(var.security_group_description, "Security group for ${var.instance_name}")
  vpc_id      = var.vpc_id

  tags = var.security_group_tags
}

locals {
  control_ingress_rules = {
    for rule in var.ingress_rules : sha1(jsonencode(rule)) => rule
  }
  control_egress_rules = {
    for rule in var.egress_rules : sha1(jsonencode(rule)) => rule
  }
}

resource "aws_vpc_security_group_ingress_rule" "control" {
  for_each = local.control_ingress_rules

  security_group_id = aws_security_group.control.id
  description       = try(each.value.description, null)
  from_port         = try(each.value.from_port, null)
  to_port           = try(each.value.to_port, null)
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "control" {
  for_each = local.control_egress_rules

  security_group_id = aws_security_group.control.id
  description       = try(each.value.description, null)
  from_port         = try(each.value.from_port, null)
  to_port           = try(each.value.to_port, null)
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}
