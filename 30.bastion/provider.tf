terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
    backend "s3" {
    bucket         = "remote-state-dev-devcops-sg"
    key            = "roboshop-dev-sg-bastion"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}