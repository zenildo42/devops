resource "aws_vpc" "VPC_teste" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "VPC teste"
}
} 
resource "aws_subnet" "Public_subnet" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.VPC_teste.id
  cidr_block              = element(var.subnets_cidr,count.index)
  availability_zone       = element(var.azs,count.index)
  map_public_ip_on_launch = var.mapPublicIP 
tags = {
   Name = "Subnet-${count.index+1}"
}
}

/*
data "aws_subnet_ids" "sub_ids" {
  vpc_id = aws_vpc.VPC_teste.id
}


output "test" {
  value = "${element(aws_subnet.Public_subnet.*.id, 0 )}"
}
*/

/*resource "aws_network_acl" "Public_NACL" {
  vpc_id = aws_vpc.VPC_teste.id
  subnet_ids = "${aws_subnet.Public_subnet.*.id}"
tags = {
    Name = "Public NACL T"
}
}



resource "aws_network_acl_rule" "Public_NACL" { 
  count  = length(var.ports)
  network_acl_id = aws_network_acl.Public_NACL.id
  rule_number    = "${100 + count.index}"
  egress         = false
  protocol   = "tcp"
  rule_action     = "allow"
  cidr_block = var.publicdestCIDRblock 
  from_port  = "${element(var.ports, count.index)}"
  to_port    = "${element(var.ports, count.index)}"
}
  
resource "aws_network_acl_rule" "Public_NACL2" { 
  count  = length(var.ports)
  network_acl_id = aws_network_acl.Public_NACL.id
  rule_number    = "${100 + count.index}"
  egress         = true
  protocol   = "tcp"
  rule_action     = "allow"
  cidr_block = var.publicdestCIDRblock 
  from_port  = "${element(var.ports, count.index)}"
  to_port    = "${element(var.ports, count.index)}"
}
 
*/
resource "aws_internet_gateway" "IGW_teste" {
 vpc_id = aws_vpc.VPC_teste.id
 tags = {
        Name = "Internet gateway teste"
}
} 
resource "aws_route_table" "Public_RT" {
 vpc_id = aws_vpc.VPC_teste.id
 tags = {
        Name = "Public Route table"
}
} 

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.Public_RT.id
  destination_cidr_block = var.publicdestCIDRblock
  gateway_id             = aws_internet_gateway.IGW_teste.id
}

resource "aws_route_table_association" "Public_association" {
  count          = "${length(aws_subnet.Public_subnet.*.id)}"
  subnet_id      = "${element(aws_subnet.Public_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.Public_RT.id
}
