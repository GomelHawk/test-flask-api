output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.vpc.default_security_group_id
}

output "private_subnets" {
  description = "Private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnets"
  value       = module.vpc.public_subnets
}