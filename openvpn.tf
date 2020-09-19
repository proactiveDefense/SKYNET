resource "aws_instance" "vpn" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.management.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "VPN"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.vpn.public_ip
  }

  provisioner "file" {
    source = "./file/vpn.env"
    destination = "/home/ubuntu/vpn.env"
  }

  provisioner "remote-exec" {
    script = "./script/provisionVPN.sh"
  }



  #provisioner "local-exec" {
    #command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.openstack_keypair} ubuntu@${openstack_networking_floatingip_v2.wr_manager_fip.address}:~/client.token ."
  #}

}

output "ip-vpn" {
  value = aws_instance.vpn.public_ip
}