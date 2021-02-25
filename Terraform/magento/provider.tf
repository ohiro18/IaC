provider "aws" {
  profile    = "default"
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "mysql" {
  endpoint = aws_db_instance.my_db.endpoint
  username = aws_db_instance.my_db.username
  password = aws_db_instance.my_db.password
}
