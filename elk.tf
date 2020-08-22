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

output "ip-elk" {
  value = aws_instance.elk.public_ip
}

