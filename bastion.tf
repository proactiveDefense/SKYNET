resource "aws_instance" "bastion" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.management.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "BASTION"
  }

}

output "ip-bastion" {
  value = aws_instance.bastion.public_ip
}

