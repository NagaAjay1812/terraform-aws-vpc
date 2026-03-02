resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags

}
# 2. Create the Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = local.ig_final_tags
}

# 3. create the  public subnets 
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true # Key setting to auto-assign public IPs

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}" # roboshop-dev-public-us-east-1a/1b
    },
    var.public_subnet_tags
  )

}

# 4. create the  private subnets 
resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false # Key setting to auto-assign public IPs

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}" # roboshop-dev-private-us-east-1a/1b
    },
    var.private_subnet_tags
  )

}

# 5. create the database subnets 
resource "aws_subnet" "database" {
  count                   = length(var.database_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false # Key setting to auto-assign public IPs

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}" # roboshop-dev-database-us-east-1a/1b
    },
    var.database_subnet_tags
  )

}

# 6. create Route table for public
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public-rt" # roboshop-dev-public-rt
    },
    var.public_route_table_tags
  )
}

# 7. Create a Route in the Route Table
# This route directs all outbound traffic (0.0.0.0/0) to the Internet Gateway.
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

}

# 7. Associate the Route Table with the Public Subnet
# This links the created route table with the specified subnet.
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


# 8. create Route table for private
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-rt" # roboshop-dev-private-rt
    },
    var.private_route_table_tags
  )
}

# 9. create Route table for database
resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-rt" # roboshop-dev-database-rt
    },
    var.database_route_table_tags
  )
}

# 10. Associate the Route Table with the private Subnet
# This links the created route table with the specified subnet.
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

# 11. Associate the Route Table with the database Subnet
# This links the created route table with the specified subnet.

resource "aws_route_table_association" "database_subnet_association" {
  count          = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database_rt.id
}


# 12. Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main] # Ensure IGW is created first
}

# 13. Create the NAT Gateway in the public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id # only one subnet
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-NAT" # roboshop-dev-NAT
    },
    var.nat_tags
  )
}

# 14. Create a Private Route Table (directs to NAT Gateway)
resource "aws_route" "private_internet_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
# 15. Create a database Route Table (directs to NAT Gateway)
resource "aws_route" "database_internet_route" {
  route_table_id         = aws_route_table.database_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}



