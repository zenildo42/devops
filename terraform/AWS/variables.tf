variable "region" {
     default = "us-east-1"
}
variable "availabilityZone" {
     default = "us-east-1a"
}
variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "publicdestCIDRblock" {
    default = "0.0.0.0/0"
}
variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "subnets_cidr" {
	type = list
	default = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24", "10.20.4.0/24", "10.20.5.0/24", "10.20.6.0/24"]
}

variable "azs" {
	type = list
	default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

/*variable "subnets_ids" {
	type = list
}
*/
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = false
}

variable "ips_liberados" {
    type = list
    default = [ "150.165.250.0/24" ]
}

variable "ports" {
    default = [22, 80, 8080, 443]
}