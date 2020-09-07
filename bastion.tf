resource "aws_instance" "bastion" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.management.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "BASTION"
  }

}

output "ip-bastion" {
  value = aws_instance.bastion.public_ip
}


resource "null_resource" "connection_elk" {
  connection {
    bastion_host = aws_instance.bastion.public_ip
    host         = aws_instance.elk.private_ip
    user         = "ubuntu"
    private_key  = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "./script/provisionEK.sh"
  }

  provisioner "file" {
    source = "./file/GeoLite2-City.mmdb"
    destination = "/tmp/GeoLite2-City.mmdb"
  }
  provisioner "file" {
    source = "./file/log-cow.conf"
    destination = "/tmp/log-cow.conf"
  }

  provisioner "remote-exec" {
    script = "./script/provisionL.sh"
  }
}

resource "null_resource" "connect_conpot2" {
  connection {
    bastion_host = aws_instance.bastion.public_ip
    host         = aws_instance.conpot2.private_ip
    user         = "ubuntu"
    private_key  = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "./script/provisionConpot.sh"
  }

}