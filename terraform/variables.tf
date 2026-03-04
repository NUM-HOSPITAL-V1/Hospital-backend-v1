variable "aws_region" {
  description = "AWS region where resources are created."
  type        = string
  default     = "eu-north-1"
}

variable "ami_id" {
  description = "AMI ID for the control node EC2 instance."
  type        = string
  default     = "ami-001413555755c0cf7"
}

variable "instance_type" {
  description = "EC2 instance type for the control node."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name."
  type        = string
  default     = "hospital-key"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance."
  type        = string
  default     = "control-node"
}

variable "security_group_name" {
  description = "Security group name for the control node."
  type        = string
  default     = "control-node-sg"
}

variable "security_group_description" {
  description = "Security group description."
  type        = string
  default     = null
}

variable "security_group_tags" {
  description = "Tags for the security group."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID where the control security group will be created."
  type        = string
}

variable "ingress_rules" {
  description = "Inbound rules for the instance security group."
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
  default = []
}

variable "egress_rules" {
  description = "Outbound rules for the instance security group."
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
  default = [
    {
      protocol  = "-1"
      cidr_ipv4 = "0.0.0.0/0"
    }
  ]
}

variable "worker_ami_id" {
  description = "AMI ID for the worker node EC2 instance."
  type        = string
  default     = null
}

variable "worker_instance_type" {
  description = "EC2 instance type for the worker node."
  type        = string
  default     = "t3.micro"
}

variable "worker_key_name" {
  description = "Existing EC2 key pair name for worker."
  type        = string
  default     = null
}

variable "worker_instance_name" {
  description = "Name tag for the worker EC2 instance."
  type        = string
  default     = "worker-node"
}

variable "worker_security_group_name" {
  description = "Security group name for the worker node."
  type        = string
  default     = "worker-node-sg"
}

variable "worker_security_group_description" {
  description = "Worker security group description."
  type        = string
  default     = null
}

variable "worker_security_group_tags" {
  description = "Tags for the worker security group."
  type        = map(string)
  default     = {}
}

variable "worker_ingress_rules" {
  description = "Inbound rules for the worker security group."
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
  default = []
}

variable "worker_egress_rules" {
  description = "Outbound rules for the worker security group."
  type = list(object({
    description = optional(string)
    from_port   = optional(number)
    to_port     = optional(number)
    protocol    = string
    cidr_ipv4   = string
  }))
  default = [
    {
      protocol  = "-1"
      cidr_ipv4 = "0.0.0.0/0"
    }
  ]
}
