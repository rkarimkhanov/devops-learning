output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.wordpress.public_ip
}

output "wordpress_url" {
  description = "WordPress URL"
  value       = format("http://%s", aws_instance.wordpress.public_ip)
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = format("ssh -i %s.pem ec2-user@%s", var.key_name, aws_instance.wordpress.public_ip)
}