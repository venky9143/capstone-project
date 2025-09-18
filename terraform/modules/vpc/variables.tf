variable "vpc_id" {
  description = "The ID of the VPC to deploy resources in"
  type        = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "zone_names" {
  description = "A list of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  
}