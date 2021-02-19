output "vpc" {
  value = {
    vpc = alicloud_vpc.vpc
  }
}

output "vsw" {
  value = {
    vsw = alicloud_vswitch.vsw
  }
}
