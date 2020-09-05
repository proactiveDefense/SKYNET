resource "aws_instance" "nat" {
  ami           = "ami-00a9d4a05375b2763" #NAT AMI
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.vpc_dmz.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]
  source_dest_check = false

  tags = {
    Name = "NAT"
  }

  #depends_on = [aws_key_pair.skynet_key, aws_instance.elk]

  #creates ssh connection to consul servers
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host     = aws_instance.nat.public_ip
  }

}

output "ip-nat" {
  value = aws_instance.nat.public_ip
}
