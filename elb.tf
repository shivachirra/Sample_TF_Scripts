terraform {
  required_version = "> 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "teju-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1" 
    # Enable during Step-09     
    # For State Locking
    #dynamodb_table = "terraform-dev-state-table"    
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


# Create a new load balancer
resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-east-1a", "us-east-1b"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  tags = {
    Name = "foobar-terraform-elb"
  }
}