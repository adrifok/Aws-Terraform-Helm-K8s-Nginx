#!/bin/bash

set -x

# Load environment variables from .env file
if [ -f .env ]; then
        export $(grep -v '^#' .env | xargs)
fi

echo "DOCKER_USERNAME: $DOCKER_USERNAME"
echo "DOCKER_PASSWORD: $DOCKER_PASSWORD"

# Debugging: Print a message to indicate the script has started
echo "Starting setup.sh script execution..."

# Update
sudo apt-get update -y

# Install Java for dependencies
sudo apt install openjdk-11-jre -y 

# Install Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER
newgrp docker

# Install AWS CLI
sudo apt-get install awscli -y

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Create an EKS cluster
eksctl create cluster --name devops-exercise --version 1.21 --region us-east-1 --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Configure kubectl to access your EKS cluster
aws eks update-kubeconfig --region us-east-1 --name devops-exercise

# Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

helm version || { echo "Helm installation failed"; exit 1; }

# Add the EKS stable repository
helm repo add eks https://aws.github.io/eks-charts

# Update your local Helm chart repository cache
helm repo update

# Install AWS Load Balancer Controller
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=devops-exercise --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set region=us-east-1 --set vpcId=vpc-0819b5c47f5adf0fa

# Debugging: Print a message to indicate Helm installation
echo "Helm installation completed."

# Build a Docker image that includes the YAML files

docker build -t adrifok/my-app .

# Log in to Docker Hub

echo 'DOCKER_PASSWORD' | docker login -u 'DOCKER_USERNAME' --password-stdin

# Push the Docker image to your Docker Hub repository

docker push adrifok/my-app

# Run a Docker container on the remote machine

docker run -v /app:/app my-app bash -c "
    kubectl apply -f /app/devops-exercise-front.yaml
    kubectl apply -f /app/devops-exercise-front-service.yaml
    kubectl apply -f /app/devops-exercise-back.yaml
    kubectl apply -f /app/devops-exercise-back-service.yaml
"
