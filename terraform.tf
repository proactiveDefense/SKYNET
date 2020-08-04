provider "aws" {
  profile	= "default"
  region  = "us-east-1"
}

variable "public_key_path" { type = string }
variable "private_key_path" { type = string }
variable "ami" { default = "ami-06c8ff16263f3db59" } #UBUNTU 20.04 LTS

resource "aws_key_pair" "skynet_key" {
  key_name   = "key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "skynet_dash" {
  ami		    = var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name


  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.skynet_dash.public_ip
  }

  provisioner "remote-exec" {
    script = "./script/skynetProv.sh"
  }

  provisioner "file" {
    source = "./file/inadyn.conf"
    destination = "/tmp/inadyn.conf"
  }

  provisioner "remote-exec" {
    script = "./script/skynetStart.sh"
  }

}

output "ip_dash" {
  value = aws_instance.skynet_dash.public_ip
}