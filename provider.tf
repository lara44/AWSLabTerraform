terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "luisrojas-bucket-states-demo"
    key = "kubernetes/kubernetes.tfstate"
    encrypt = true
    region = "us-east-1"
    shared_config_files = [ "$HOME/.aws/credentials" ]
    profile = "default"
    dynamodb_table = "luisrojaskubernetes"
  }
}
provider "aws" {
  shared_config_files      = ["$HOME/.aws/config"]
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                  = "default"
  region                   = "us-east-1"
}