resource "aws_instance" "elk" {
  ami			= var.ami
  instance_type	= "t2.medium"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.elk_subnet.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]
  private_ip = "10.0.102.6"
  tags = {
    Name = "ELK"
  }

  connection {
    bastion_host = aws_instance.bastion.public_ip
    host         = aws_instance.elk.private_ip
    user         = "ubuntu"
    private_key  = file(var.private_key_path)
  }

  provisioner "file" {
    source = "./file/export.ndjson"
    destination = "/tmp/export.ndjson"
  }
  provisioner "file" {
    source = "./file/dash_pihole.ndjson"
    destination = "/tmp/dash_pihole.ndjson"
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
  value = aws_instance.elk.private_ip
}