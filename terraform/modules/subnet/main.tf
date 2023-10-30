resource "aws_subnet" "tfsubnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.az

  tags = {
    Name = "${var.env}-tfsubnet"
  }
}

resource "aws_internet_gateway" "tfgw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-tfgw"
  }
}

resource "aws_route_table" "tfroute" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfgw.id
  }

  tags = {
    Name = "${var.env}-tfroute"
  }
}

resource "aws_route_table_association" "tfass" {
  subnet_id = aws_subnet.tfsubnet.id
  route_table_id = aws_route_table.tfroute.id
}