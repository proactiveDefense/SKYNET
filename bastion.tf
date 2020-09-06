resource "aws_instance" "bastion" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.management.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "BASTION"
  }


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

  #depends_on = [aws_key_pair.skynet_key, aws_instance.elk]
  /*
  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.bastion.public_ip
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
  */
}

output "ip-bastion" {
  value = aws_instance.bastion.public_ip
}