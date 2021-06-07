# VPC 
resource "aws_vpc" "my_vpc_two" {
  cidr_block           = var.vpc_cidr_block_secondary
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.is_enabled_dns_support
  enable_dns_hostnames = var.is_enabled_dns_hostnames
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_vpc"
    }
  )
}

# Public Subnets
resource "aws_subnet" "second_public_subnet" {
  count             = length(var.second_subnet_azs)
  vpc_id            = aws_vpc.my_vpc_two.id
  cidr_block        = element(var.second_pub_cidr_subnet, count.index)
  availability_zone = element(var.second_subnet_azs, count.index)
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_pub_sub_${count.index}"
    }
  )
}

# Private Subnets
resource "aws_subnet" "second_private_subnet" {
  count             = length(var.second_subnet_azs)
  vpc_id            = aws_vpc.my_vpc_two.id
  cidr_block        = element(var.second_priv_cidr_subnet, count.index)
  availability_zone = element(var.second_subnet_azs, count.index)
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_priv_sub_${count.index}"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "second_igw" {
  vpc_id = aws_vpc.my_vpc_two.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_igw"
    }
  )
}

# Public Route Table
resource "aws_route_table" "second_pub_rtb" {
  vpc_id = aws_vpc.my_vpc_two.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.second_igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_pub_rtb"
    }
  )
}

# Public Route Table Association
resource "aws_route_table_association" "second_pub_subnets" {
  count = length(var.second_subnet_azs)

  subnet_id      = element(aws_subnet.second_public_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.second_pub_rtb.*.id, count.index)
}

# Elastic IP
resource "aws_eip" "second_nat_gw_eip" {
  vpc = true
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_eip"
    }
  )
}

# Nat Gateway
resource "aws_nat_gateway" "second_nat_gw" {
  depends_on    = [aws_internet_gateway.second_igw]
  allocation_id = aws_eip.second_nat_gw_eip.id
  subnet_id     = aws_subnet.second_public_subnet[0].id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_nat_gw"
    }
  )
}

# Private Route Table
resource "aws_route_table" "second_private_rtb" {
  vpc_id = aws_vpc.my_vpc_two.id

  route {
    cidr_block     = var.rt_cidr_block
    nat_gateway_id = aws_nat_gateway.second_nat_gw.id
  }
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_secondary_private_rtb"
    }
  )
}

# Private Route Table Association
resource "aws_route_table_association" "second_priv_subnets" {
  count = length(var.second_subnet_azs)

  subnet_id      = element(aws_subnet.second_private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.second_private_rtb.*.id, count.index)
}