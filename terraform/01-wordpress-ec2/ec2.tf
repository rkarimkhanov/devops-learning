resource "aws_instance" "wordpress" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.wordpress_sg.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user-data-ec2.sh")

  tags = {
    Name = "wordpress-ec2"
  }
}