data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}


data "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "route.gateway-id"
    values = ["igw-*"] # Filters for routes pointing to an Internet Gateway
  }
}
