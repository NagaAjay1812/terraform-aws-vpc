output "azs_info" {
  value = data.aws_availability_zones.available
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "public_route_table_id" {
  value = data.aws_route_table.public_rt.id
}
