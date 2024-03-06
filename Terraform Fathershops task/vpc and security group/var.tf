

#vpc
variable "vpc_cidr_block" {
  description = "Fathershop CIDR block range"
  type        = string
  default     = "13.0.0.0/16"
}


#subnet

variable "subnet_cidr_block" {
  description = "Fathershop CIDR block for subnet"
  type        = string
  default     = "13.0.1.0/24"
}

variable "subnet_availability_zone" {
  description = "Fathershop Availability Zone for subnet"
  type        = string
  default     = "us-east-2a"
}

variable "subnet_pvt_cidr_block" {
  description = "Fathershop CIDR block for the private subnet"
  type        = string
  default     = "13.0.2.0/24"
}

variable "subnet_pvt_availability_zone" {
  description = "Fathershop Availability Zone for the private subnet"
  type        = string
  default     = "us-east-2b"
}


#sg

variable "sg_name" {
  description = "Fathershop security group"
  type        = string
  default     = "allow_tls"
}

variable "sg_description" {
  description = "Fathershop security group"
  type        = string
  default     = "Allow TLS inbound traffic"
}


