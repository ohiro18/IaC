provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "alicloud_vpc" "vpc" {
  name = "${var.project_name}-vpc"
  cidr_block = "192.168.1.0/24"
  description = "Enable Bastion-Server vpc"  
}

resource "alicloud_vswitch" "vsw" {
  name = "${var.project_name}-vswitch"  
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
  description = "Enable Bastion-Server vswitch"  
}

# SSH踏み台専用
resource "alicloud_security_group" "sg_bastion_server" {
  name   = "${var.project_name}_Bastion_Server"
  description = "Enable SSH access via port 22"  
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_bastion_server.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ECS_instance_for_Bastion_Server" {
  instance_name   = "${var.project_name}-Bastion-Server-ECS-instance"
  host_name       = "${var.project_name}-Bastion-Server-ECS-instance"
  instance_type   = "ecs.xn4.small"
  image_id        = "centos_7_04_64_20G_alibase_201701015.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg_bastion_server.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  password = "${var.ecs_bastion_server_password}"
  internet_max_bandwidth_out = 5
}

# 実行サーバ専用
resource "alicloud_security_group" "sg_production_server" {
  name   = "${var.project_name}_Production_Server"
  description = "Marker security group for Production server"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_production_server.id}"
  cidr_ip           = "0.0.0.0/0"
}

# 実行サーバへssh接続はssh踏み台サーバのみ許容する
resource "alicloud_security_group_rule" "allow_ssh_for_Bastion" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_production_server.id}"
  cidr_ip           = "${alicloud_instance.ECS_instance_for_Bastion_Server.public_ip}" 
}

resource "alicloud_instance" "ECS_instance_for_Production_Server" {
  instance_name   = "${var.project_name}-Production-Server-ECS-instance"
  host_name   = "${var.project_name}-Production-Server-ECS-instance"
  instance_type   = "ecs.n4.small"
  image_id        = "centos_7_04_64_20G_alibase_201701015.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg_production_server.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  internet_max_bandwidth_out = 5
  password = "${var.ecs_production_server_password}"
  user_data = "${file("provisioning.sh")}"
}
