output "ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance.*.public_ip}"
}
output "slb_ip" {
  value = "${alicloud_slb.default.address}"
}
output "rds_host" {
  value = "${alicloud_db_instance.db_instance.connection_string}"
}
