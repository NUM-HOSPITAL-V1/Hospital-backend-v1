variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "worker_ami_id" {
  type     = string
  nullable = true
}

variable "worker2_ami_id" {
  type     = string
  nullable = true
}

variable "worker_instance_type" {
  type = string
}

variable "worker_key_name" {
  type     = string
  nullable = true
}

variable "worker_instance_name" {
  type = string
}

variable "worker2_instance_name" {
  type = string
}

variable "control_sg_id" {
  type = string
}

variable "worker_sg_id" {
  type = string
}
