output "instance_public_ip" {
  value       = aws_instance.devops_exercise.public_ip
  description = "The public IP address of the EC2 instance."
}
output "instance_private_ip" {
  value       = aws_instance.devops_exercise.private_ip
  description = "The private IP address of the EC2 instance."
}

output "instance_state" {
  value       = aws_instance.devops_exercise.instance_state
  description = "The state of the EC2 instance."
}

output "instance_subnet_id" {
  value       = aws_instance.devops_exercise.subnet_id
  description = "The ID of the subnet in which the EC2 instance is located."
}

output "elastic_ip_address" {
  value = aws_instance.devops_exercise.public_ip
}

