data "template_file" "client" {
  template = file("./script/provisionConpot.sh")
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client.rendered
  }
}

resource "aws_instance" "conpot" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.vpc_private.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]
  user_data     = data.template_cloudinit_config.config.rendered

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
}

output "ip-conpot" {
  value = aws_instance.conpot.private_ip
}
