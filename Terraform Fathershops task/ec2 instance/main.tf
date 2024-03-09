provider "aws" {
  region = var.region
}
resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.keyname

  vpc_security_group_ids = [aws_security_group.sgpub.id]
  subnet_id     = aws_subnet.subpub.id
  vpc_id        = aws_vpc.myvpc.id

  tags = {
    Name = "FathershopEC2Instance"
  }
}
