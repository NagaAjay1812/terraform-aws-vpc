locals {
  common_tags = {
    project_name = var.project
    environment  = var.environment
    Terraform    = true

  }
  vpc_final_tags = merge(
    local.common_tags,
    var.tags
  )
}
