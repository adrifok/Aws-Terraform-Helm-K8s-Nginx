resource "null_resource" "copy_nginx_conf" {
  # Copy the setup.sh script to the remote server
  provisioner "file" {
    source      = "setup.sh"
    destination = "/home/ubuntu/setup.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  # Make the setup.sh script executable and execute it
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/setup.sh",
      "/home/ubuntu/setup.sh",
      "sudo mkdir -p /etc/nginx/sites-available"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  # Copy the nginx configuration file to a temporary location
  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise"
    destination = "/home/ubuntu/temp_nginx.conf"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  # Move the nginx configuration file to the destination directory
  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ubuntu/temp_nginx.conf /etc/nginx/sites-available/default",
      "mkdir -p /home/ubuntu/devops-exercise"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  # Copy the devops-exercise directory from your local machine to the remote server
  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise"
    destination = "/home/ubuntu/devops-exercise"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }
 # Copy the Dockerfile to the remote server
  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise/Dockerfile"
    destination = "/home/ubuntu/Dockerfile"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }
  # Copy the docker-compose.yml file to the remote server
  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise/docker-compose.yaml"
    destination = "/home/ubuntu/docker-compose.yml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  # Copy the Kubernetes YAML files to the remote server
  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise/devops-exercise-front.yaml"
    destination = "/home/ubuntu/devops-exercise-front.yaml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise/devops-exercise-front-service.yaml"
    destination = "/home/ubuntu/devops-exercise-front-service.yaml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise/devops-exercise-back.yaml"
    destination = "/home/ubuntu/devops-exercise-back.yaml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }

  provisioner "file" {
    source      = "/home/adri/Documents/devops-exercise/devops-exercise-back-service.yaml"
    destination = "/home/ubuntu/devops-exercise-back-service.yaml"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/adri/Documents/devops-exercise/devops-exercise.pem")
      host        = aws_instance.devops_exercise.public_ip
    }
  }
}