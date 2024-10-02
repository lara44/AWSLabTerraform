# VPC Configuration
resource "aws_vpc" "vpckubernetedemo" {
  cidr_block       = "192.168.8.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "ITMLab_VirtualDemo"
  }
}

# Public Subnet 1 (192.168.8.0/27)
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpckubernetedemo.id
  cidr_block              = "192.168.8.0/27"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet1"
  }
}

# Public Subnet 2 (192.168.8.32/27)
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpckubernetedemo.id
  cidr_block              = "192.168.8.32/27"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet2"
  }
}

# Private Subnet 1 (192.168.8.64/27)
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.vpckubernetedemo.id
  cidr_block        = "192.168.8.64/27"
  availability_zone = "us-east-1a"
  tags = {
    Name = "PrivateSubnet1"
  }
}

# Private Subnet 2 (192.168.8.96/27)
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.vpckubernetedemo.id
  cidr_block        = "192.168.8.96/27"
  availability_zone = "us-east-1d"
  tags = {
    Name = "PrivateSubnet2"
  }
}

# Internet Gateway con nombre personalizado
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpckubernetedemo.id
  tags = {
    Name = "ITMLab_VirtualInternetGatewayDemo"
  }
}

# Single Route Table for both Public and Private Subnets
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.vpckubernetedemo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "MainRouteTable"
  }
}

# Associate Route Table with Public and Private Subnets
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.main.id
}
