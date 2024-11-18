# create key pair
resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "aws_ec2_private_key" {
  key_name   = var.key_name_eks
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}
