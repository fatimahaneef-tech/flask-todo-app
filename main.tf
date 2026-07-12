terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Generate SSH key pair
resource "tls_private_key" "todo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "todo_key" {
  key_name   = "todo-app-key"
  public_key = tls_private_key.todo_key.public_key_openssh
}

# Save private key locally
resource "local_file" "private_key" {
  filename        = "${path.module}/todo-app-key.pem"
  content         = tls_private_key.todo_key.private_key_pem
  file_permission = "0400"
}

# Security group
resource "aws_security_group" "todo_sg" {
  name_prefix = "todo-app-sg"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "todo_server" {
  ami                    = "ami-0b910d1016287a5e7"  # Amazon Linux 2023 (Free Tier eligible)
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.todo_sg.id]
  key_name               = aws_key_pair.todo_key.key_name
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user
              EOF
  
  tags = {
    Name = "todo-app-server"
  }
}
# Outputs
output "server_public_ip" {
  value = aws_instance.todo_server.public_ip
}

output "ssh_command" {
  value = "ssh -i todo-app-key.pem ubuntu@${aws_instance.todo_server.public_ip}"
}