output "Bastion-Server-ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance_for_Bastion_Server.*.public_ip}"
}

output "Production-Server-ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance_for_Production_Server.*.public_ip}"
}
