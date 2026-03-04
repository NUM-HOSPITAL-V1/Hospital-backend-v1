output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.control.id
}

output "instance_public_ip" {
  description = "Public IP address of the control node."
  value       = aws_instance.control.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the control node."
  value       = aws_instance.control.public_dns
}

output "security_group_id" {
  description = "Security group ID attached to the control node."
  value       = aws_security_group.control.id
}

output "worker_instance_id" {
  description = "EC2 instance ID for worker node."
  value       = aws_instance.worker.id
}

output "worker_instance_public_ip" {
  description = "Public IP address of the worker node."
  value       = aws_instance.worker.public_ip
}

output "worker_security_group_id" {
  description = "Security group ID attached to the worker node."
  value       = aws_security_group.worker.id
}
