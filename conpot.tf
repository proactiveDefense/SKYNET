resource "aws_instance" "conpot" {
  ami			= var.ami
  instance_type	= "t2.micro"
  key_name		= aws_key_pair.skynet_key.key_name
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.cowrie.id]

  tags = {
    Name = "CONPOT"
  }

}

output "ip-conpot" {
  value = aws_instance.conpot.private_ip
}

