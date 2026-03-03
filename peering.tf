

resource "aws_vpc_peering_connection" "default" {
  count       = var.is_peering_required ? 1 : 0
  vpc_id      = aws_vpc.main.id         #Requestor -  roboshop-dev vpc 
  peer_vpc_id = data.aws_vpc.default.id #Accepter -  default vpc or opposite connection

  auto_accept = true

  accepter { allow_remote_vpc_dns_resolution = true }
  requester { allow_remote_vpc_dns_resolution = true }

  tags = merge(local.common_tags, {
    Name = "${var.project}-${var.environment}-to-default-vpc"
  })
}

# Route from Roboshop VPC → Default VPC CIDR
resource "aws_route" "public_peering" {
  count                     = var.is_peering_required ? 1 : 0 # if user mentioned is_required_peering = false its not created
  route_table_id            = aws_route_table.public_rt.id    # whatevr route table you want 
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[0].id
}

# Route from Default VPC → Roboshop VPC CIDR (return route)
resource "aws_route" "default_peering" {
  count                     = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.default_main.id # default vpc main route table
  destination_cidr_block    = var.cidr_block                       #  your roboshop VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.default[0].id
}

data "aws_vpc" "default" {
  default = true
}

data "aws_route_table" "default_main" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}
