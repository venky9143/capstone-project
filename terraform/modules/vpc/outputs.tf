output "vpc_id" {
  description = "The ID of the VPC where resources are deployed"
  value       = data.aws_vpc.default.id
}

output "subnet_ids" {
  description = "The IDs of the subnets in the VPC"
  value       = data.aws_subnets.filtered.ids
}