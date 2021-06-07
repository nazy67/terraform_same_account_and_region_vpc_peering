# VPC outputs
output "vpc_id" {
  value = aws_vpc.my_vpc_one.id
}
output "private_subnets_ids" {
  value = aws_subnet.private_subnet[*].id
}
output "public_subnets_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "internet gateway id"
}
output "nat_gw_id" {
  value       = aws_nat_gateway.nat_gw.id
  description = "nat gateway id"
}
output "pub_rtp_id" {
  value       = aws_route_table.pub_rtb.id
  description = "public route table id"
}
output "priv_rtp_id" {
  value       = aws_route_table.private_rtb.id
  description = "private route table id"
}