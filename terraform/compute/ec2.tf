resource "aws_instance" "control" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    var.control_sg_id
  ]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_instance" "worker" {
  ami           = coalesce(var.worker_ami_id, var.ami_id)
  instance_type = var.worker_instance_type
  key_name      = coalesce(var.worker_key_name, var.key_name)
  vpc_security_group_ids = [
    var.worker_sg_id
  ]

  tags = {
    Name = var.worker_instance_name
  }
}

resource "aws_instance" "worker2" {
  ami           = coalesce(var.worker2_ami_id, var.ami_id)
  instance_type = var.worker_instance_type
  key_name      = coalesce(var.worker_key_name, var.key_name)
  vpc_security_group_ids = [
    var.worker_sg_id
  ]

  tags = {
    Name = var.worker2_instance_name
  }
}
