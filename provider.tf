terraform {
    required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 2. Set your preferred AWS region
provider "aws" {
  region = "us-east-1"
}