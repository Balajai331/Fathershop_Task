# Provider configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#vpc.tf

variable "region" {}

provider "aws" {
  region = var.region
}