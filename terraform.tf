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

