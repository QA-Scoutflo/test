locals {
  name_prefix = "prod-ec2"
  tags = {
    Name        = local.name_prefix
    CostCenter  = var.cost_center
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
