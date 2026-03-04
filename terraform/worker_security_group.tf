resource "aws_security_group" "worker" {
  name        = var.worker_security_group_name
  description = coalesce(var.worker_security_group_description, "Security group for ${var.worker_instance_name}")
  vpc_id      = var.vpc_id

  tags = var.worker_security_group_tags
}

locals {
  worker_ingress_rules_map = {
    for rule in var.worker_ingress_rules : sha1(jsonencode(rule)) => rule
  }
  worker_egress_rules_map = {
    for rule in var.worker_egress_rules : sha1(jsonencode(rule)) => rule
  }
}

resource "aws_vpc_security_group_ingress_rule" "worker" {
  for_each = local.worker_ingress_rules_map

  security_group_id = aws_security_group.worker.id
  description       = try(each.value.description, null)
  from_port         = try(each.value.from_port, null)
  to_port           = try(each.value.to_port, null)
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "worker" {
  for_each = local.worker_egress_rules_map

  security_group_id = aws_security_group.worker.id
  description       = try(each.value.description, null)
  from_port         = try(each.value.from_port, null)
  to_port           = try(each.value.to_port, null)
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}
