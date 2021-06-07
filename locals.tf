locals {
  common_tags = {
    Environment = var.env
    Project     = "${var.env}-peering"
    Team        = "Development"
    Owner       = "nazy@gmail.com"
  }
}