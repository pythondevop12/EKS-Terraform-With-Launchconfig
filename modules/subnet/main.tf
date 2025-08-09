locals {
  public_subnet_bits  = 4
  private_subnet_bits = 4
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = var.vpc_id
  count             = 2
  cidr_block        = cidrsubnet(var.vpc_cidr_block, local.public_subnet_bits, count.index)
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name"        = "${terraform.workspace}-public-subnet-${count.index + 1}"
    "Environment" = "${terraform.workspace}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

}
resource "aws_subnet" "private_subnets" {
  vpc_id            = var.vpc_id
  count             = 2
  cidr_block        = cidrsubnet(var.vpc_cidr_block, local.private_subnet_bits, count.index+2)
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name"        = "${terraform.workspace}-private-subnet-${count.index + 1}"
    "Environment" = "${terraform.workspace}"
    "kubernetes.io/cluster/${var.eks_cluster_name}"      = "shared"
    "kubernetes.io/role/internal-elb"                = "1"
  }

}
