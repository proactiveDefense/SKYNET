resource "aws_instance" "heralding" {
  ami				= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name

  tags = {
    Name = "HERALDING"
  }

  #depends_on = [aws_instance.elk]

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.heralding.public_ip
  }

}

output "ip-heralding" {
  value = aws_instance.heralding.public_ip
}