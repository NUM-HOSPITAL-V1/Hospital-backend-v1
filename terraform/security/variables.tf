variable "vpc_id" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type     = string
  nullable = true
}

variable "security_group_tags" {
  type = map(string)
}

variable "ingress_rules" {
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
}

variable "egress_rules" {
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
}

variable "worker_instance_name" {
  type = string
}

variable "worker_security_group_name" {
  type = string
}

variable "worker_security_group_description" {
  type     = string
  nullable = true
}

variable "worker_security_group_tags" {
  type = map(string)
}

variable "worker_ingress_rules" {
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
}

variable "worker_egress_rules" {
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
}
