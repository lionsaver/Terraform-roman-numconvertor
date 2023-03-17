terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}


resource "aws_instance" "trf-ec2" {
  # ami = "ami-005f9685cb30f234b"
  ami             = data.aws_ami.tf_ami.id
  instance_type   = var.ec2_type
  key_name        = var.keypair
  # security_groups = [aws_security_group.ssh_http_https.name]
  vpc_security_group_ids = [aws_security_group.ssh_http_443.id]
  user_data = data.template_file.userdata.rendered
  # user_data       = "${file("user-data.sh")}"
  tags = {
    Name = local.tags
  }

  }
 
resource "aws_security_group" "ssh_http_443" {
  name        = "allow_ssh_http_https"
  description = "Allow ssh, http and https inbound traffic"
#   vpc_id      = aws_vpc.main.id
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.tags
  }
}


