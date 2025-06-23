# variables.tf

variable "region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
  default     = "example-eks-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones."
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "example-eks-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.29"
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS managed node group."
  type        = string
  default     = "t3.medium"
}

variable "node_min_size" {
  description = "Minimum number of nodes in the node group."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of nodes in the node group."
  type        = number
  default     = 4
}

variable "node_desired_size" {
  description = "Desired number of nodes in the node group."
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {
    Environment = "production"
    Terraform   = "true"
  }
}
