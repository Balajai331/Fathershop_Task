# MySQL RDS instance for WordPress
resource "aws_db_instance" "mysql_rds" {
  identifier           = var.db_instance_identifier
  allocated_storage    = var.allocated_storage
  instance_class       = "db.t3.micro"
  engine               = "mysql"
  username             = var.db_username
  password             = var.db_password
  db_name              = var.db_name
  publicly_accessible  = false
}

# Elastic IP for the EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.keyname

  vpc_security_group_ids = [aws_security_group.sgpub.id]
  subnet_id              = aws_subnet.subpub.id
  vpc_id                 = aws_vpc.myvpc.id

  tags = {
    Name = "FathershopEC2Instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo yum install -y mariadb-server",
      "sudo systemctl start mariadb",
      "sudo systemctl enable mariadb",
      "sudo yum install -y php php-mysql",
      "sudo systemctl restart httpd",
    ]
  }
}

# Configuring WordPress to use the RDS instance
resource "null_resource" "configure_wordpress" {
  depends_on = [aws_db_instance.mysql_rds, aws_instance.my_ec2]

  provisioner "local-exec" {
    command = <<-EOF
      aws ec2 associate-address --instance-id ${aws_instance.my_ec2.id} --public-ip ${aws_instance.my_ec2.public_ip}
      aws ec2 wait instance-status-ok --instance-ids ${aws_instance.my_ec2.id}
      sleep 30
      echo "<?php
        define('DB_NAME', '${aws_db_instance.mysql_rds.name}');
        define('DB_USER', '${aws_db_instance.mysql_rds.username}');
        define('DB_PASSWORD', '${aws_db_instance.mysql_rds.password}');
        define('DB_HOST', '${aws_db_instance.mysql_rds.endpoint}');
        define('DB_CHARSET', 'utf8mb4');
        define('DB_COLLATE', 'utf8mb4_unicode_ci');
      ?>" > /var/www/html/wp-config.php
    EOF
  }
}

# Creating R53 DNS record for WordPress
resource "aws_route53_record" "wordpress_dns" {
  zone_id = var.route53_zone_id
  name    = var.route53_domain
  type    = "A"
  ttl     = "300"
  records = [aws_instance.my_ec2.public_ip]
}
