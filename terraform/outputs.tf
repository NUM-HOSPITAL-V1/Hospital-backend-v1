output "instance_id" {
  description = "EC2 instance ID."
  value       = module.compute.control_instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the control node."
  value       = module.compute.control_instance_public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the control node."
  value       = module.compute.control_instance_public_dns
}

output "security_group_id" {
  description = "Security group ID attached to the control node."
  value       = module.security.control_sg_id
}

output "worker_instance_id" {
  description = "EC2 instance ID for worker node."
  value       = module.compute.worker_instance_id
}

output "worker_instance_public_ip" {
  description = "Public IP address of the worker node."
  value       = module.compute.worker_instance_public_ip
}

output "worker_security_group_id" {
  description = "Security group ID attached to the worker node."
  value       = module.security.worker_sg_id
}

output "worker2_instance_id" {
  description = "EC2 instance ID for worker2 node."
  value       = module.compute.worker2_instance_id
}

output "worker2_instance_public_ip" {
  description = "Public IP address of the worker2 node."
  value       = module.compute.worker2_instance_public_ip
}
