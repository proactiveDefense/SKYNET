resource "aws_instance" "elk" {
  ami			= var.ami
  instance_type	= "t2.medium"
  key_name		= aws_key_pair.skynet_key.key_name

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.elk.public_ip
  }

  provisioner "remote-exec" {
    script = "./script/provisionELK.sh"
  }
}

output "ip-elk" {
  value = aws_instance.elk.public_ip
}

