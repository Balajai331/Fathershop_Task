# variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "db_instance_identifier" {
  description = "DB instance"
  type        = string
  default     = "db isnstace"
}

variable "db_username" {
  description = "Username"
  type        = string
  default     = "Bala"
}

variable "db_password" {
  description = "Password"
  type        = string
  default     = "welcome@123"
}

variable "db_name" {
  description = "Name of the  database"
  type        = string
  default     = "fathershop"
}

variable "allocated_storage" {
  description = "storage capacity "
  type        = number
  default     = "35"
}
