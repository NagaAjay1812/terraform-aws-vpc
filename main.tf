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

# 3. create the  public subnets and 
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  availability_zone = var.desired_azs[count.index]
  cidr_block        = var.public_subnet_cidrs[count.index]


  tags = local.subnet_pub1a_final_tags
}


