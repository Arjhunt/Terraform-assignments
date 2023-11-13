# Define variables
variable "aws_region_ohio" {
  description = "The AWS region for Ohio"
  default     = "us-east-2"
}


variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}