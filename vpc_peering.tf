resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = aws_vpc.my_vpc_two.id
  vpc_id        = aws_vpc.my_vpc_one.id
  auto_accept   = false

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(
    local.common_tags,
    {
      Side = "Requester",
      Name = "${var.env}_vpc_peering"
    }
  )
}

// resource "aws_vpc_peering_connection_accepter" "accepter_peering" {
//   vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
//   auto_accept               = true

//   tags = merge(
//       local.common_tags,
//       {
//         Side = "Accepter",
//         Name = "${var.env}_vpc_peering"
//       }
//     )

resource "aws_route" "primary2secondary" {
  route_table_id            = aws_vpc.my_vpc_one.main_route_table_id
  destination_cidr_block    = var.secondary_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "secondary2primary" {
  route_table_id            = aws_vpc.my_vpc_two.main_route_table_id
  destination_cidr_block    = var.primary_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}