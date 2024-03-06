
variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type = string
  default = "ami-1234"
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type = string
  default = "c4.xlarge"
}

variable "keyname" {
  description = "The key name for EC2 instance"
  type = string
  default = "keypair"
}
