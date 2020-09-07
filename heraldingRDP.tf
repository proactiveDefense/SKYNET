resource "aws_instance" "heraldingRDP" {
  ami				= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.dmz.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "HERALDING-RDP"
  }

  #depends_on = [aws_key_pair.skynet_key, aws_instance.elk]

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.heraldingRDP.public_ip
  }

  provisioner "file" {
    source = "./file/heraldingRDP.yml"
    destination = "/tmp/heralding.yml"
  }
  provisioner "remote-exec" {
    script = "./script/provisionHeralding.sh"
  }

  provisioner "file" {
    source = "./file/metric-cowrie.yml"
    destination = "/tmp/metricbeat.yml"
  }
  provisioner "file" {
    source = "./file/filebeat-heralding.yml"
    destination = "/tmp/filebeat-heralding.yml"
  }
  /*
  provisioner "remote-exec" {
    script = "./script/startHeralding.sh"
  }
  */
}

output "ip-heralding-RDP" {
  value = aws_instance.heraldingRDP.public_ip
}