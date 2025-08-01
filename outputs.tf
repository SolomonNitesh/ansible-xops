output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.xops_ec2.public_ip
}
 
output "web_url" {
  description = "URL to access the web app"
  value       = "http://${aws_instance.xops_ec2.public_ip}"
}