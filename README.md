# AWS EKS Cluster Terraform Module

This Terraform configuration provisions a production-ready AWS EKS (Elastic Kubernetes Service) cluster with the following features:

- Creation of a new VPC with public and private subnets
- EKS cluster with managed node group (t3.medium, min=2, max=4, desired=2)
- Latest available Kubernetes version (default: 1.29)
- Secure IAM roles for cluster and node group
- Basic security groups and networking
- Outputs for cluster endpoint and kubeconfig

## Usage

1. **Initialize Terraform:**
   ```sh
   terraform init
   ```
2. **Review and customize variables in `terraform.tfvars` as needed.**
3. **Plan and apply:**
   ```sh
   terraform apply
   ```

## Outputs
- `cluster_endpoint`: EKS cluster API endpoint
- `kubeconfig`: Kubeconfig file content (sensitive)
- `cluster_name`: EKS cluster name

## Requirements
- Terraform >= 1.3.0
- AWS credentials with permissions to create EKS, VPC, IAM, and related resources

## Security & Best Practices
- Uses official Terraform AWS modules for VPC and EKS
- Private subnets for worker nodes
- NAT Gateway for outbound internet access
- IRSA enabled for secure pod IAM roles

---

**Note:** Destroying this stack will remove all created AWS resources, including the EKS cluster and VPC.
