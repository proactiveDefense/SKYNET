resource "aws_instance" "ssh_honeypot" {
  ami				= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name

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

  provisioner "remote-exec" {
    script = "./script/startCowrie.sh"
  }

}

output "ip-cowrie" {
  value = aws_instance.ssh_honeypot.public_ip
}

