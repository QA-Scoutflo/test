variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance. Defaults to latest Amazon Linux 2."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance."
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to access the instance via SSH."
  type        = string
  default     = "0.0.0.0/0"
}

variable "cost_center" {
  description = "Tag for cost allocation."
  type        = string
  default     = "production"
}

variable "environment" {
  description = "Tag for environment."
  type        = string
  default     = "production"
}
