locals{
    ami_id = data.aws_ami.roboshop.id
    common_tags ={
        Project = var.project
        Environment = var.environment
        Terraform = true
  }
    pub_sub_id = split(", ", data.aws_ssm_parameter.public_subnet_id.value)[0]
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_name.value
}