terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.78.0"
    }
  }
}

provider "aws" {
  region     = "eu-north-1"
  access_key = "############################"
  secret_key = "###########################"
}