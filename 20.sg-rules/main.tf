resource "aws_security_group_rule" "bastion_internet" {
    type            = "ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.bastion_sg_id 
}

resource "aws_security_group_rule" "mongodb_bastion" {
    type            = "ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    source_security_group_id = local.bastion_sg_id
    #cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.mongodb_sg_id
}


resource "aws_security_group_rule" "mongodb_catalogue" {
    type            = "ingress"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    source_security_group_id = local.catalogue_sg_id
    #cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
    type            = "ingress"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    source_security_group_id = local.user_sg_id
    #cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.mongodb_sg_id
}


################# Redis ######################3

resource "aws_security_group_rule" "redis_bastion" {
    type            = "ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    source_security_group_id = local.cart_sg_id
    #cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_cart" {
    type            = "ingress"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    source_security_group_id = local.cart_sg_id
    #cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.redis_sg_id
}


################# mysql  ######################

resource "aws_security_group_rule" "mysql_bastion" {
    type            = "ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    source_security_group_id = local.mysql_sg_id
    #cidr_blocks     = ["0.0.0.0/0"]
    #cider_blocks = [local.my_ip]

    # here we need to give security group id
    security_group_id = local.mysql_sg_id
}


