terraform {
  backend "s3" {
    bucket = "nazy-tf-bucket"
    key    = "dev/vpc_one.tfstate"
    region = "us-east-1"
  }
}