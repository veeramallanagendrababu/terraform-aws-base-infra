variable "vpc_id" {
  description = "VPC ID where subnet will be created"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
