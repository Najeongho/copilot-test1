# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create two subnets with /21 CIDR blocks
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.16.0.0/21"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet1"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "172.16.8.0/21"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet2"
    "kubernetes.io/role/elb" = "1"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create a route table for subnet1 and associate it with the internet gateway
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.my_vpc.id
  
}

resource "aws_route" "route1" {
  route_table_id         = aws_route_table.route_table1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_internet_gateway.id
  
}

resource "aws_route_table_association" "route_asso1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table1.id
}

# Create a route table for subnet2 and associate it with the internet gateway
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "route2" {
  route_table_id         = aws_route_table.route_table2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_internet_gateway.id
}

resource "aws_route_table_association" "route_asso2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table2.id
}