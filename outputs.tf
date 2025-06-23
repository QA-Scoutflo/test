# outputs.tf

output "cluster_endpoint" {
  description = "EKS cluster endpoint URL."
  value       = module.eks.cluster_endpoint
}

output "kubeconfig" {
  description = "Kubeconfig file content for the EKS cluster."
  value       = module.eks.kubeconfig
  sensitive   = true
}

output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}
