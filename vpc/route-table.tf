resource "aws_route_table" "public-rtb" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.new-igw.id
    }
    tags = {
        Name = "${var.prefix}-rtb"
    }
}

resource "aws_route_table_association" "new-rtb-association" {
    count = 2
    route_table_id = aws_route_table.public-rtb.id
    subnet_id = aws_subnet.public-subnets.*.id[count.index]
}