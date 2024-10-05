terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  
  backend "s3" {
    bucket = "pjdevops-state-dev"
    key    = "payment"
    region = "us-east-1"
    dynamodb_table = "pjdevops-locking-dev"
    }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}