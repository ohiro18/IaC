output "vpc" {
  value = {
    vpc = aws_vpc.vpc
  }
}

output "subnet" {
  value = {
    subnet = aws_subnet.subnet
  }
}
