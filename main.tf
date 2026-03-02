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
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public1a_cidr_block

  tags = local.subnet_pub1a_final_tags
}


