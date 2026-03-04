resource "aws_instance" "worker" {
  ami           = coalesce(var.worker_ami_id, var.ami_id)
  instance_type = var.worker_instance_type
  key_name      = coalesce(var.worker_key_name, var.key_name)
  vpc_security_group_ids = [
    aws_security_group.worker.id
  ]

  tags = {
    Name = var.worker_instance_name
  }
}
