variable "project" {
    default = "roboshop"
  
}

variable "environment" {
    default = "dev"
  
}



variable "sg_names" {
    type = list
    default = [

        # databases
        "mongodb", "redis", "mysql", "rabbitmq",
        # backends  
        "catalogue", "user", "cart", "shipping", "payment",
        # backned_ALB
        "backend_alb",
        #frontend
        "frontend",
        # frontend alb
        "frontend-alb",
        #bastion
        "bastion"
    ]
  
}