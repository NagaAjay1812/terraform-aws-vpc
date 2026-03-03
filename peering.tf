resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1 : 0
  #peer_owner_id = var.peer_owner_id

  #Accepter -  default vpc or opposite connection
  peer_vpc_id = data.aws_vpc.default.id

  #Requestor -  roboshop-dev vpc 
  vpc_id = aws_vpc.main.id

  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(local.common_tags, {
    Name = "${var.project}-${var.environment}-to-default-vpc"
  })

}


resource "aws_route" "requester_to_default_peering_route" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default.id

}




