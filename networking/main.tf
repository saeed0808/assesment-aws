# Define VPC, subnets, security groups, and other networking resources here.

resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count = length(var.subnet_cidr_blocks)
  vpc_id = aws_vpc.example.id
  cidr_block = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = var.public_subnet_tags
}

resource "aws_subnet" "private" {
  count = length(var.subnet_cidr_blocks)
  vpc_id = aws_vpc.example.id
  cidr_block = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = var.private_subnet_tags
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route_table" "public" {
  count = length(aws_subnet.public)

  vpc_id = aws_vpc.example.id

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table" "private" {
  count = length(aws_subnet.private)

  vpc_id = aws_vpc.example.id

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route" "public_internet_gateway" {
  count = length(aws_subnet.public)

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example.id
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Security group for ECS instances"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to specific IPs in production
  }

  # Add more ingress rules as needed.
}

# Define security group rules and other networking configurations here.

