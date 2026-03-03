resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1 : 0
  #peer_owner_id = var.peer_owner_id

  #Accepter -  default vpc or opposite connection
  peer_vpc_id = data.aws_vpc.default.id

  #Requestor -  roboshop-dev vpc 
  vpc_id = aws_vpc.main.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
