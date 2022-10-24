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
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
 

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# 8.Create Ubuntu server and install/enable apache 2.
resource "aws_instance" "Thesis_server" {
  ami               = "ami-09d3b3274b6c5d4aa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "web-server-key-pair"

 


  user_data = <<-EOF
          #!/bin/bash
          yum -y install httpd
          systemctl enable httpd
          systemctl start httpd
          echo '<html><h1>Hello From Your Web Server!</h1></html>' > /var/www/html/index.html
              EOF



  tags = {
    Name = "Lab"
  }
}
