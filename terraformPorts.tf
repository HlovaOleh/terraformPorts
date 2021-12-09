provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-00bdbdac0da69a3b4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
}

resource "aws_security_group" "my_webserver" {
  name        = "Webserver Security Group"
  description = "My First Security Group"

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["0.0.0.0/0"]
      self             = false
      security_groups  = []
      prefix_list_ids  = []
    }
  ]

  egress = [
    {
      description      = "User-service ports"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      security_groups  = []
      prefix_list_ids  = []
    }
  ]

  tags = {
    Name = "allow_tls"
  }
}