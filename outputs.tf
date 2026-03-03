output "azs_info" {
  value = data.aws_availability_zones.available
}

output "main_vpc_id" {
  value = data.aws_vpc.main.id
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "publc_subnet_ids" {
  value = data.aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = data.aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = data.aws_subnet.database[*].id
}



