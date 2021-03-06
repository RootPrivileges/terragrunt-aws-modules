output "internet_gateway_id" {
  value       = "${aws_internet_gateway.gw.id}"
  description = "The ID of the VPC internet gateway"
}

output "private_subnets" {
  value = module.private_subnets
}

output "public_subnets" {
  value = module.public_subnets
}

output "vpc_id" {
  value       = "${aws_vpc.vpc.id}"
  description = "The ID of the VPC"
}
