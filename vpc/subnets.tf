data "aws_availability_zones" "available" {}

resource "aws_subnet" "public-subnets" {
    count = 2
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-subnet-${count.index}"
        "kubernetes.io/cluster/${var.prefix}-${var.cluster_name}" = "owned"
        "kubernetes.io/role/elb" = "1"
    }
}

resource "aws_subnet" "private-subnets" {
    count = 2
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.${count.index+2}.0/24"
    tags = {
        Name = "${var.prefix}-private-subnet-${count.index}"
        "kubernetes.io/cluster/${var.prefix}-${var.cluster_name}" = "owned"
        "kubernetes.io/role/internal-elb" = "1"
    }
}