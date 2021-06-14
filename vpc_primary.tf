resource "aws_vpc" "my_vpc_one" {
  cidr_block           = var.primary_vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.is_enabled_dns_support
  enable_dns_hostnames = var.is_enabled_dns_hostnames
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_vpc"
    }
  )
}

# Public Subnets
resource "aws_subnet" "first_public_subnet" {
  count             = length(var.first_subnet_azs)
  vpc_id            = aws_vpc.my_vpc_one.id
  cidr_block        = element(var.first_pub_cidr_subnet, count.index)
  availability_zone = element(var.first_subnet_azs, count.index)
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_pub_sub_${count.index}"
    }
  )
}

# Private Subnets
resource "aws_subnet" "first_private_subnet" {
  count             = length(var.first_subnet_azs)
  vpc_id            = aws_vpc.my_vpc_one.id
  cidr_block        = element(var.first_priv_cidr_subnet, count.index)
  availability_zone = element(var.first_subnet_azs, count.index)
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_priv_sub_${count.index}"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "first_igw" {
  vpc_id = aws_vpc.my_vpc_one.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_igw"
    }
  )
}

# Public Route Table
resource "aws_route_table" "first_pub_rtb" {
  vpc_id = aws_vpc.my_vpc_one.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.first_igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_pub_rtb"
    }
  )
}

# Public Route Table Association
resource "aws_route_table_association" "first_pub_subnets" {
  count = length(var.first_subnet_azs)

  subnet_id      = element(aws_subnet.first_public_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.first_pub_rtb.*.id, count.index)
}

# Elastic IP
resource "aws_eip" "first_nat_gw_eip" {
  vpc = true
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_eip"
    }
  )
}

# Nat Gateway
resource "aws_nat_gateway" "first_nat_gw" {
  depends_on    = [aws_internet_gateway.first_igw]
  allocation_id = aws_eip.first_nat_gw_eip.id
  subnet_id     = aws_subnet.first_public_subnet[0].id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_nat_gw"
    }
  )
}

# Private Route Table
resource "aws_route_table" "first_private_rtb" {
  vpc_id = aws_vpc.my_vpc_one.id

  route {
    cidr_block     = var.rt_cidr_block
    nat_gateway_id = aws_nat_gateway.first_nat_gw.id
  }
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_primary_private_rtb"
    }
  )
}

# Private Route Table Association
resource "aws_route_table_association" "first_priv_subnets" {
  count = length(var.first_subnet_azs)

  subnet_id      = element(aws_subnet.first_private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.first_private_rtb.*.id, count.index)
}