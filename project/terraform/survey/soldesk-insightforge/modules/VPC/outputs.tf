output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.terraform-vpc.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = [
    aws_subnet.terraform-BASTION-PUB-2A.id,
    aws_subnet.terraform-NGINX-PUB-2A.id,
    aws_subnet.terraform-NGINX-PUB-2C.id
  ]
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = [
    aws_subnet.terraform-TOMCAT-PRI-2A.id,
    aws_subnet.terraform-DB-PRI-2A.id,
    aws_subnet.terraform-TOMCAT-PRI-2C.id,
    aws_subnet.terraform-DB-PRI-2C.id
  ]
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.terraform-nat-gw.id
}

output "nginx_security_group" {
  description = "The ID of the NGINX security group"
  value       = aws_security_group.terraform-sg-nginx.id
}

output "tomcat_security_group" {
  description = "The ID of the TOMCAT security group"
  value       = aws_security_group.terraform-sg-tomcat.id
}

output "db_security_group" {
  description = "The ID of the DB security group"
  value       = aws_security_group.terraform-sg-db.id
}


output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.terraform-BASTION-PUB-2A.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.terraform-sg-bastion.id
}