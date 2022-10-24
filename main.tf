terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
}
  tags = {
    Name = "Terraform Lab"
  }

# 1.Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
# 2.Create Internet Gateway
# 3.Create a subnet
# 4.Associate subnet with route table
# 5.Create security group to allow following PORT (22,80,443)
# 6.Create a network interface with an IP that was created in step 4.
# 7.Assaign an EIP & attach to IG
# 8.Create Ubuntu server and install/enable apache 2.