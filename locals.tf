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
}
