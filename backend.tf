terraform {
  backend "s3" {
    bucket = "nazy-tf-bucket"
    key    = "dev/vpc_peering.tfstate"
    region = "us-east-1"
  }
}