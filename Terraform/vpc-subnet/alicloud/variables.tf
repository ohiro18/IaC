variable "base_name" {
  description = "Name of the cluster"
  default     = "test"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "subnet_offset" {
  default     = 0
  description = "subnet offset (from main VPC cidr_block) number to be cut"
}

variable "subnet_netmask_bits" {
  default     = 8
  description = "default 8 bits in /16 CIDR, makes it /24 subnetworks"
}

variable "alicloud_region" {
  default = "ap-northeast-1"
}

variable "alicloud_access_key" {
  description = "The Alicloud Access Key ID to launch resources. Support to environment 'ALICLOUD_ACCESS_KEY'."
  default     = "access_key"
}

variable "alicloud_secret_key" {
  description = "The Alicloud Access Secret Key to launch resources.  Support to environment 'ALICLOUD_SECRET_KEY'."
  default     = "secret_key"
}
