output "ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance_for_SLB_Sample.*.public_ip}"
}
output "slb_ip" {
  value = "${alicloud_slb.default.address}"
}
