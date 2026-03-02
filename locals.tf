locals {
  common_tags = {
    project_name = var.project
    environment  = var.environment
    Terraform    = true

  }
  vpc_final_tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}" # roboshop-dev 
    },
    var.vpc_tags
  )
  ig_final_tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}" # roboshop-dev 
    },
    var.ig_tags
  )
  subnet_pub1a_final_tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-${var.public}-${var.desired_azs[count.index]}" # roboshop-dev-public-us-east-1a/1b
    },
    var.subnet_tags
  )
}
