terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"  # replace with your desired version
    }
  }
  required_version = ">= 1.3.2"
}