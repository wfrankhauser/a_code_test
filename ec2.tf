resource "tls_private_key" "ec2_instance" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "wfrankhauser"
  public_key = tls_private_key.ec2_instance.public_key_openssh
}

resource "local_file" "ssh_key" {
    content     = tls_private_key.ec2_instance.private_key_pem
    filename = "${path.module}/wfrankhauser.pem"
}

resource "aws_instance" "api_nodes" {
  count = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${aws_security_group.ssh_to_ec2.id}"]
  subnet_id = aws_subnet.main.id
  user_data = "${path.module}/sources/user_data.sh"
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "wfrankhauser"
  }
}
