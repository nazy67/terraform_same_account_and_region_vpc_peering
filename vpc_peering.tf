resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = aws_vpc.my_vpc_two.id
  vpc_id        = aws_vpc.my_vpc_one.id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_vpc_peering"
    }
  )
}


resource "aws_route" "first_pub_rtb_2_second_pub_rtb" {
  route_table_id            = aws_route_table.first_pub_rtb.id
  destination_cidr_block    = var.secondary_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "second_pub_rtb_2_first_pub_rtb" {
  route_table_id            = aws_route_table.second_pub_rtb.id
  destination_cidr_block    = var.primary_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}