resource "random_password" "first" {
  length  = 16
  special = false
  min_lower = 8
  min_upper = 8
}
