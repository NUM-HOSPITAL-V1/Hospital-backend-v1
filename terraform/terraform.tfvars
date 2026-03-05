aws_region                 = "eu-north-1"
ami_id                     = "ami-0974a2c5ddf10f442"
instance_type              = "t3.micro"
key_name                   = "ubuntu-3"
instance_name              = "control-node"
security_group_name        = "control-node-sg"
security_group_description = "Security group for control-node"
security_group_tags        = {}
vpc_id                     = "vpc-0800002d15fc879c7"

ingress_rules = [
  { from_port = 22, to_port = 22, protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
  { from_port = 6443, to_port = 6443, protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" }

]

egress_rules = [
  { protocol = "-1", cidr_ipv4 = "0.0.0.0/0" }
]

worker_ami_id                     = "ami-0974a2c5ddf10f442"
worker_instance_type              = "t3.micro"
worker_key_name                   = "ubuntu-2"
worker_instance_name              = "worker-node"
worker_security_group_name        = "worker-node-sg"
worker_security_group_description = "Security group for worker-node"
worker_security_group_tags        = {}

worker_ingress_rules = [
  { from_port = 22, to_port = 22, protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
  { from_port = 6443, to_port = 6443, protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" }
]

worker_egress_rules = [
  { protocol = "-1", cidr_ipv4 = "0.0.0.0/0" }
]
