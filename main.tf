provider "aws" {
  region = "us-east-1"
}

# IAM Role for EC2 to use SSM
resource "aws_iam_role" "ec2_ssm_role" {
  name = "EC2SSMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the AmazonSSMManagedInstanceCore policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create an instance profile for the IAM role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile-devops"
  role = aws_iam_role.ec2_ssm_role.name
}

# EC2 Instance
resource "aws_instance" "devops_exercise" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.xlarge"
  key_name      = "devops-exercise"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id = "subnet-0db13a2d6c80be909" 

  tags = {
    Name = "devops-exercise"
  }
}

output "instance_id" {
  value = aws_instance.devops_exercise.id
}
