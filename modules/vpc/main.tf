resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_val
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${terraform.workspace}-k8svpc"
    "Environment" = "${terraform.workspace}"
  }
}

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name          = "${var.region}.compute.internal"
  domain_name_servers  = ["AmazonProvidedDNS"]

  tags = {
    "Name" = "${terraform.workspace}-dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver_association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}
