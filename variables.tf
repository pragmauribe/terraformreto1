variable "CIDR_VPC" {
  type        = list(string)
  description = "CIDR VPC"
}

variable "CIDR_Public" {
  type        = list(string)
  description = "CIDR Public Subnets"
}

variable "CIDR_Private" {
  type        = list(string)
  description = "CIDR Private Subnets"
}

variable "availability_zone" {
  type        = list(string)
  description = "AWS Availability Zones"
}

variable "Subnet_Public" {
  type        = list(string)
  description = "Names of Subnets"
}

variable "Subnet_Private" {
  type        = list(string)
  description = "Names of Subnets"
}