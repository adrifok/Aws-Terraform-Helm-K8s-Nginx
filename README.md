Three Tier Application

I deployed  a three-tier "Click Counter" application , developed in Typescript and Nuxt.js (Vue.js), contained in this Git Hub repository.

My app is structured in 3 micro services: “front”, “back”, and “Redis” database within the “back” folder.  Terraform will be the orchestrator tool to launch an AWS EC2 with all the requirements: security groups, providers, eks cluster config, policies, routes, outputs.

First of all I wrote a script named `setup.sh` that is located in the root directory of the application. Here's what it does:

Install Java and Docker
Install the CLI for AWS
Instal eksctl for EKS command line tool
Install kubectl for interacting with Kubernetes clusters
Install Helm, as a package manager for Kubernetes;  to create chart repository cache.
Installs the AWS Load Balancer Controller on the Kubernetes cluster, using Helm.
Builds a Docker image named `my-app` using the Dockerfile in the current directory.
Runs a Docker container from the `my-app` image. It mounts the `/app` directory from the host to the `/app` directory in the container. 
Then it executes a series of `kubectl apply` commands to apply the Kubernetes configurations defined in the `devops-exercise-front.yaml`, `devops-exercise-front-service.yaml`, `devops-exercise-back.yaml`, and `devops-exercise-back-service.yaml` files.

I write a Dockerfile and a Docker compose file
I write 2 deployment (one for back image and the other for front image) and 2 Services for deployment (one for back image and the other for front image)
BackEnd binds to port 4000
Front End binds to port 3000
Redis db binds to port 6379
I created an Reverse Proxy with Nginx. This file (nginx.conf at the root directory) hides all the ports for security and redirected its to port 80.

Then I run Terraform init, plan and apply to launch the EC2 and the EKS clusters.

I write the commands to create a Docker network and connect containers to it should be run inside your EC2 instance if that's where are running the Docker containers.

docker network create my-network
docker network connect my-network frontend
docker network connect my-network backend


5. Finally, I rebuild your Nginx Docker image and restart the container. You can do this with the `docker build` and `docker run` commands, or with Docker Compose if you're using it.
The app is exposed locally (localhost:80) and to the web throught the Public Ip.
I upload the app to the GitHub repository and I wrote a yaml file to continous deploymentHub Ac through Git Hub Actions, every time a new commit is pushed.
