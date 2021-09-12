# Provider Configuration Used For Authenticating with AWS
# Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.37.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

}