resource "aws_instance" "conpot" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "CONPOT"
  }

  connection {
    bastion_host = aws_instance.bastion.public_ip
    host         = aws_instance.conpot.private_ip
    user         = "ubuntu"
    private_key  = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "./script/provisionConpot.sh"
  }

  provisioner "file" {
    source = "./file/filebeat-conpot.yml"
    destination = "/tmp/filebeat.yml"
  }
  provisioner "file" {
    source = "./file/metric-cowrie.yml"
    destination = "/tmp/metricbeat.yml"
  }
  provisioner "file" {
    source = "./file/MASTER_sym.py"
    destination = "/home/ubuntu/MASTER_sym.py"
  }
  provisioner "file" {
    source = "./file/OVERALL.pcap"
    destination = "/home/ubuntu/OVERALL.pcap"
  }

  provisioner "remote-exec" {
    script = "./script/startConpot.sh"
  }

}

output "ip-conpot" {
  value = aws_instance.conpot.private_ip
}

