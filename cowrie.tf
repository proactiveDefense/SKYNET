/*
resource "aws_key_pair" "chiave_magica" {
  key_name   = "chiave_magica"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ssh_honeypot" {
  ami				= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.chiave_magica.key_name


  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.ssh_honeypot.public_ip
  }

  provisioner "remote-exec" {
    script = "./script/provision.sh"
  }

  provisioner "file" {
    source = "./file/cowrie.cfg"
    destination = "cowrie/etc/cowrie.cfg"
  }

  provisioner "remote-exec" {
    script = "./script/start.sh"
  }

}

output "ip" {
  value = aws_instance.ssh_honeypot.public_ip
}
*/
