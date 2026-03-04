resource "aws_instance" "control" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.control.id
  ]

  tags = {
    Name = var.instance_name
  }
}
