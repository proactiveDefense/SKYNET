provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

variable "public_key_path" { type = string }
variable "private_key_path" { type = string }
variable "ami" { default = "ami-06c8ff16263f3db59" } #UBUNTU 20.04 LTS

resource "aws_key_pair" "skynet_key" {
  key_name   = "key"
  public_key = file(var.public_key_path)
}

resource "aws_vpc" "skynet_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "skynetVPC"
  }
}

resource "aws_internet_gateway" "skynet_igw" {
  vpc_id = aws_vpc.skynet_vpc.id
  tags = {
    Name = "skynetIGW"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.skynet_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.skynet_igw.id
}

resource "aws_subnet" "vpc_dmz" {
  vpc_id                  = aws_vpc.skynet_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "DMZ"
  }
}

resource "aws_security_group" "cowrie" {
  name        = "cowrie"
  description = "cowrie security policy"
  vpc_id      = aws_vpc.skynet_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cowrie"
  }
}