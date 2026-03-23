locals {
    common_tags = {
        project = var.project
        environment = var.environment
        Terraform = true
    }
  
ami_id = data.aws_ami.roboshop.id
database_subnet_id = split(", ", data.aws_ssm_parameter.database_subnet_id.value)[0]
mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value

}