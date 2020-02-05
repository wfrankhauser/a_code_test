#output "public_key" {
#  value = tls_private_key.ec2_instance.public_key_openssh
#}

#output "private_key" {
#  value = tls_private_key.ec2_instance.private_key_pem
#}

output "host_dns" {
  value = aws_instance.api_nodes.*.public_dns
}
