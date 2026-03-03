output "azs_info" {
  value = data.aws_availability_zones.available
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}


