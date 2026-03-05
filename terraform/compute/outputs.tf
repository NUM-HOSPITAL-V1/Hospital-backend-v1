output "control_instance_id" {
  value = aws_instance.control.id
}

output "control_instance_public_ip" {
  value = aws_instance.control.public_ip
}

output "control_instance_public_dns" {
  value = aws_instance.control.public_dns
}

output "worker_instance_id" {
  value = aws_instance.worker.id
}

output "worker_instance_public_ip" {
  value = aws_instance.worker.public_ip
}

output "worker2_instance_id" {
  value = aws_instance.worker2.id
}

output "worker2_instance_public_ip" {
  value = aws_instance.worker2.public_ip
}
