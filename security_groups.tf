# Define security group rules for the devops-exercise instance
resource "aws_security_group" "devops-exercise" {
  name        = "devops-exercise security group"
  description = "Security group for the devops-exercise instance"
  vpc_id      = "vpc-0819b5c47f5adf0fa" # Your VPC Id

  # Ingress rule for HTTP traffic on port 80
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your desired IP range for incoming HTTP traffic
  }

  # Ingress rule for SSH traffic on port 22
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your IP address or use 0.0.0.0/0 for open access.
  }

  # Egress rule for all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  
  }
}

