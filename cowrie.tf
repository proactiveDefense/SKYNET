/*resource "aws_instance" "ssh_honeypot" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.vpc_dmz.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "COWRIE"
  }


  depends_on = [aws_key_pair.skynet_key, aws_instance.elk]

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.ssh_honeypot.public_ip
  }

  provisioner "remote-exec" {
    script = "./script/provisionCowrie.sh"
  }

  provisioner "file" {
    source = "./file/cowrie.cfg"
    destination = "cowrie/etc/cowrie.cfg"
  }
  provisioner "file" {
    source = "./file/filebeat-cowrie.yml"
    destination = "/tmp/filebeat.yml"
  }
  provisioner "file" {
    source = "./file/metric-cowrie.yml"
    destination = "/tmp/metricbeat.yml"
  }

  provisioner "remote-exec" {
    script = "./script/startCowrie.sh"
  }

}

output "ip-cowrie" {
  value = aws_instance.ssh_honeypot.public_ip
}*/
