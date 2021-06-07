# Providers variables
variable "aws_region" {
  type        = string
  description = " aws region to deploys your infra"
}

# VPC variables
variable "vpc_cidr_block_primary" {
  type        = string
  description = "cidr block for the primary vpc"
}

variable "vpc_cidr_block_secondary" {
  type        = string
  description = "cidr block for the secondary vpc"
}

variable "instance_tenancy" {
  type        = string
  description = "the tenancy of existing VPCs from dedicated to default instantly"
}

variable "is_enabled_dns_support" {
  type        = bool
  description = "enabling dns support"
}

variable "is_enabled_dns_hostnames" {
  type        = bool
  description = "enabling dns hostnames"
}

variable "rt_cidr_block" {
  type        = string
  description = "route table cidr block"
}

# Subnet variables
variable "first_subnet_azs" {
  type        = list(string)
  description = "The availabitily zones where terraform deploys your infra"
}

variable "second_subnet_azs" {
  type        = list(string)
  description = "The availabitily zones where terraform deploys your infra"
}

variable "first_pub_cidr_subnet" {
  type        = list(string)
  description = "cird blocks for the public subnets"
}

variable "second_pub_cidr_subnet" {
  type        = list(string)
  description = "cird blocks for the public subnets"
}

variable "first_priv_cidr_subnet" {
  type        = list(string)
  description = "cidr blocks for the private subnets"
}

variable "second_priv_cidr_subnet" {
  type        = list(string)
  description = "cidr blocks for the private subnets"
}

# Tags variables
variable "env" {
  type        = string
  description = "name of the environment"
}