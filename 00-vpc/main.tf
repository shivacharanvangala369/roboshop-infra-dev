module "vpc" {
    source = "../../terraform-vpc-module"
    project = var.project
    environment = var.environment
    is_peering_required = true
  
}