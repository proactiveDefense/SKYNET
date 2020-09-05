resource "aws_instance" "conpot2" {
  ami			= var.ami #conpot
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.vpc_private.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "TEST"
  }

}

output "ip-test" {
  value = aws_instance.conpot2.private_ip
}
