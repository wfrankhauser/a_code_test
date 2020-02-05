output "public_key" {
  value = "${tls_private_key.ec2_instance.public_key_openssh}"
}
