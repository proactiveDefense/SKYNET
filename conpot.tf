resource "aws_instance" "conpot" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name

  tags = {
    Name = "CONPOT"
  }

  depends_on = [aws_key_pair.skynet_key, aws_instance.elk]

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.conpot.public_ip
  }
  /*
  provisioner "remote-exec" {
    script = "./script/provisionConpot.sh"
  }
  */
}

output "ip-conpot" {
  value = aws_instance.conpot.public_ip
}
