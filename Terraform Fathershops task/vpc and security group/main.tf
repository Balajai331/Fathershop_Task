
# VPC
resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "MY-VPC"
  }
}

# Subnets
resource "aws_subnet" "subpub" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone

  tags = {
    Name = "MY-SUB-PUB"
  }
}

resource "aws_subnet" "subpvt" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_pvt_cidr_block
  availability_zone = var.subnet_pvt_availability_zone

  tags = {
    Name = "MY-SUB-PVT"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tgw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "T-IGW"
  }
}

# Route Tables
resource "aws_route_table" "rtpub" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tgw.id
  }

  tags = {
    Name = "MY-RT-PUB"
  }
}

resource "aws_route_table" "rtpvt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tnat.id
  }

  tags = {
    Name = "MY-RT-PVT"
  }
}

# Route Table Associations
resource "aws_route_table_association" "rtpubasc" {
  subnet_id      = aws_subnet.subpub.id
  route_table_id = aws_route_table.rtpub.id
}

resource "aws_route_table_association" "rtpvtasc" {
  subnet_id      = aws_subnet.subpvt.id
  route_table_id = aws_route_table.rtpvt.id
}

# Security Group
resource "aws_security_group" "sgpub" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "alltcp"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}

# Elastic IP
resource "aws_eip" "eip" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "tnat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subpub.id

  tags = {
    Name = "T-NAT"
  }
}
