terraform {
  required_version = ">= 0.13.1"
  required_providers {
    aws = ">=5.38.0"
    local = ">=2.4.1"
  }
  backend "s3" {
    bucket = "iburguer-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

