
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  
}

variable "bucket" {
  description = "fathershopbuckettask"
  type        = string
  default     = "fathershopbucket"
}

variable "acl" {
  description = "ACL for the S3 bucket"
  type        = string
  default     = "private"
}



provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "fathershopbucket" {
  bucket = var.bucket  
  acl    = var.acl
}
