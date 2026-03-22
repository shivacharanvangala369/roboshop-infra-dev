module "vpc" {
    source = "git::https://github.com/shivacharanvangala369/terraform-vpc-module.git?ref=main"
    project = var.project
    environment = var.environment
    is_peering_required = true
  
}