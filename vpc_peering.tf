resource "aws_vpc_peering_connection" "my_peering_requester" {
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

// resource "aws_vpc" "my_vpc_one" {
//   cidr_block = "10.0.0.0/16"
// }

// resource "aws_vpc" "my_vpc_two" {
//   cidr_block = "10.1.0.0/16"
// }