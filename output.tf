# VPC outputs
output "primary_vpc_id" {
  value = aws_vpc.my_vpc_one.id
}
output "secondary_vpc_id" {
  value = aws_vpc.my_vpc_two.id
}

output "first_private_subnets_ids" {
  value = aws_subnet.first_private_subnet[*].id
}
output "second_private_subnets_ids" {
  value = aws_subnet.second_private_subnet[*].id
}

output "first_public_subnets_ids" {
  value = aws_subnet.first_public_subnet[*].id
}
output "second_public_subnets_ids" {
  value = aws_subnet.second_public_subnet[*].id
}

output "first_igw_id" {
  value       = aws_internet_gateway.first_igw.id
  description = "internet gateway id"
}
output "second_igw_id" {
  value       = aws_internet_gateway.second_igw.id
  description = "internet gateway id"
}

output "first_nat_gw_id" {
  value       = aws_nat_gateway.first_nat_gw.id
  description = "nat gateway id"
}
output "second_nat_gw_id" {
  value       = aws_nat_gateway.second_nat_gw.id
  description = "nat gateway id"
}

output "first_pub_rtp_id" {
  value       = aws_route_table.first_pub_rtb.id
  description = "public route table id"
}
output "second_pub_rtp_id" {
  value       = aws_route_table.second_pub_rtb.id
  description = "public route table id"
}

output "first_priv_rtp_id" {
  value       = aws_route_table.first_private_rtb.id
  description = "private route table id"
}
output "second_priv_rtp_id" {
  value       = aws_route_table.second_private_rtb.id
  description = "private route table id"
}