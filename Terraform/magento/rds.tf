resource "aws_db_instance" "my_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.23"
  instance_class         = "db.t2.micro"
  port                   = 3306
  vpc_security_group_ids   = ["${aws_security_group.first1.id}"]
  name                   = "mydb"
  identifier             = var.rds_identifier
  username               = "admin"
  password               = random_password.first.result
  parameter_group_name   = aws_db_parameter_group.first.name
  skip_final_snapshot    = true
  publicly_accessible    = true
  deletion_protection    = true
  maintenance_window     = "Mon:02:00-Mon:02:30"
  backup_retention_period= 7
  max_allocated_storage  = 100
  backup_window          = "03:00-03:30"
  tags = {
    Name = "my_database_instance"
  }
}

resource "aws_db_parameter_group" "first" {
  name   = "first-parameter-group"
  family = "mysql5.7"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = 1
  }
}
