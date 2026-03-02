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
      Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}}" # roboshop-dev-public-us-east-1a/1b
    },
    var.public_subnet_tags
  )

}

# 4. create the  private subnets 
resource "aws_subnet" "public" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false # Key setting to auto-assign public IPs

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}}" # roboshop-dev-private-us-east-1a/1b
    },
    var.private_subnet_tags
  )

}

# 5. create the database subnets 
resource "aws_subnet" "public" {
  count                   = length(var.database_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_cidrs[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = false # Key setting to auto-assign public IPs

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}}" # roboshop-dev-database-us-east-1a/1b
    },
    var.database_subnet_tags
  )

}



