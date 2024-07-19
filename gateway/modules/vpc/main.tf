data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-vpc"]
  }
}

data "aws_subnets" "available-subnets" {
  filter {
    name = "tag:Name"
    values = [ "${var.prefix}-subnet-0", "${var.prefix}-subnet-1"]
  }
}

data "aws_subnets" "private-subnets" {
  filter {
    name = "tag:Name"
    values = [ "${var.prefix}-private-subnet-0", "${var.prefix}-private-subnet-1"]
  }
}