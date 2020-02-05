resource "tls_private_key" "ec2_instance" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "wfrankhauser"
  public_key = tls_private_key.ec2_instance.public_key_openssh
}

resource "aws_instance" "web" {
  count = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.lb_to_instances.id}"]
  subnet_id = aws_subnet.main.id

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "wfrankhauser"
  }
}
