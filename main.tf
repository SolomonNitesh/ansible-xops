provider "aws" {
  region = var.aws_region
}
 
resource "aws_vpc" "xops_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "xops-vpc"
  }
}
 
resource "aws_subnet" "xops_subnet" {
  vpc_id                  = aws_vpc.xops_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "xops-subnet"
  }
}
 
resource "aws_internet_gateway" "xops_igw" {
  vpc_id = aws_vpc.xops_vpc.id
}
 
resource "aws_route_table" "xops_rt" {
  vpc_id = aws_vpc.xops_vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.xops_igw.id
  }
}
 
resource "aws_route_table_association" "xops_rta" {
  subnet_id      = aws_subnet.xops_subnet.id
  route_table_id = aws_route_table.xops_rt.id
}
 
resource "aws_security_group" "xops_sg" {
  name        = "xops-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.xops_vpc.id
 
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
resource "aws_instance" "xops_ec2" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.xops_subnet.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.xops_sg.id]
  associate_public_ip_address = true
 
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable python3.8
              yum install -y python3 nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
 
  tags = {
    Name = "xops-ec2-instance"
  }
}
 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}