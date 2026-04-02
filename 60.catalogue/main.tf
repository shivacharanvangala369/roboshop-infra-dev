resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.private_subnet_id
  vpc_security_group_ids =  [local.catalogue_sg_id]
  
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}


resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id

  ]
  connection  {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.catalogue.private_ip
  }


  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
    
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
    ]
    
  }
}


resource "aws_ec2_instance_state" "catalogue" {
  depends_on = [ terraform_data.catalogue ]
 
  instance_id = aws_instance.catalogue.id
  state = "stopped"

}

resource "aws_ami_from_instance" "catalogue" {
  depends_on = [ aws_ec2_instance_state.catalogue ]
  name = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
}



resource "aws_lb_target_group" "catalogue" {
  name     = "tf-example-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60
  health_check {
    healthy_threshold = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 3
    
  }
}


resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id



  instance_initiated_shutdown_behavior = "terminate"


  instance_type = "t2.micro"



  vpc_security_group_ids = [local.catalogue_sg_id]


  update_default_version = true

  tag_specifications {
    resource_type = "instance"
 #### tags for instances
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-catalogue"
      },
      local.common_tags
    )
  }
 #### tags for volumes
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      {
          Name = "${var.project}-${var.environment}-catalogue"
      },
      local.common_tags
    )
  }
 #### tags for lunch template
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-catalogue"
      },
      local.common_tags
    )

}

resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${var.project}-${var.environment}-catalogue"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
  launch_template {
    id = aws_launch_template.catalogue.id
    version = "$Latest"
  }
  
  vpc_zone_identifier       = [local.private_subnet_id]
  target_group_arns = [aws_lb_target_group.catalogue.arn]

  tag {
    key                 = "Name"
    value               = "${var.project}-${var.environment}-catalogue"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  }
}




