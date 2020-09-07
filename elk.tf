resource "aws_instance" "elk" {
  ami			= var.ami
  instance_type	= "t2.medium"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.elk_subnet.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]
  private_ip = "10.0.102.6"
  tags = {
    Name = "ELK"
  }
}

output "ip-elk" {
  value = aws_instance.elk.private_ip
}