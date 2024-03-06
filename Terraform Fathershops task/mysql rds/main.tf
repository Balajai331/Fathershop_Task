
provider "aws" {
  region = var.region
}

resource "aws_db_instance" "mysql_rds" {
  identifier           = var.db_instance_identifier
  allocated_storage    = var.allocated_storage
  instance_class       = "db.t3.micro"
  engine               = "mysql"
  keyname              = "mykeypair"
  username             = var.db_username
  password             = var.db_password
  db_name              = var.db_name
  publicly_accessible  = false
}
