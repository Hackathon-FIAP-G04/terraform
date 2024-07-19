resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.prefix}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public-subnets.*.id[0]

  tags = {
    Name = "${var.prefix}-nat"
  }

  depends_on = [ aws_internet_gateway.new-igw ]
}

resource "aws_route_table" "rt-nat" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.prefix}-rt-nat"
  }
}

resource "aws_route_table_association" "nat-rt" {
  count = 2
  depends_on = [ aws_route_table.rt-nat ]

  subnet_id = aws_subnet.private-subnets.*.id[count.index]
  route_table_id = aws_route_table.rt-nat.id
}