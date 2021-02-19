provider "aws" {
  # access_key = var.aws_access_key # ~/.aws/credentials に設定してるから不要
  # secret_key = var.aws_secret_key # 同上
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}
locals {
  all_zones = data.aws_availability_zones.available.names
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = map(
    "Name", "${var.base_name}-vpc",
  )
}

resource "aws_subnet" "subnet" {
  count                   = length(local.all_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_netmask_bits, var.subnet_offset + count.index)
  availability_zone       = local.all_zones[count.index]
  map_public_ip_on_launch = true
  tags = map(
    "Name", "${var.base_name}-${local.all_zones[count.index]}",
  )
}
