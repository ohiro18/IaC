resource "mysql_user" "first" {
  user = var.mysql_user
  host = "%"
  plaintext_password = var.mysql_pass
}

resource "mysql_database" "first" {
  name = var.mysql_db
}

resource "mysql_grant" "first" {
  user       = mysql_user.first.user
  host       = mysql_user.first.host
  database   = mysql_database.first.name
  privileges = ["ALL"]
}
