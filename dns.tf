resource "aws_instance" "dns" {
  ami			= var.ami
  instance_type	= "t2.medium"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.elk_subnet.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]
  private_ip = "10.0.102.25"
  tags = {
    Name = "PIHOLE"
  }

  connection {
    bastion_host = aws_instance.bastion.public_ip
    host         = aws_instance.dns.private_ip
    user         = "ubuntu"
    private_key  = file(var.private_key_path)
  }

  provisioner "file" {
    source = "./file/pihole-setupVars.conf"
    destination = "/tmp/setupVars.conf"
  }

}

output "ip-dns" {
  value = aws_instance.dns.private_ip
}