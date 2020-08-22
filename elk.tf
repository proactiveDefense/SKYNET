resource "aws_key_pair" "chiave_magica" {
  key_name   = "chiave_magica"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "elk" {
  ami				= var.ami
  instance_type	= "t2.medium"
  key_name		= aws_key_pair.chiave_magica.key_name

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.elk.public_ip
  }

}

output "ip-elk" {
  value = aws_instance.elk.public_ip
}

