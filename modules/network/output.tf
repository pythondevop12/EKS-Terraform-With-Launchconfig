output "igw_arn" {
  value = aws_internet_gateway.igw.arn
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "aws_route_table_public_arn" {
  value = aws_route_table.public-RT.arn
  
}

output "aws_route_table_private_arn" {
  value = aws_route_table.private-RT.arn  
}