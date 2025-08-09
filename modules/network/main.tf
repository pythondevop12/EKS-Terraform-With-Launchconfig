resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    "Name"        = "${terraform.workspace}-igw"
    "Environment" = "${terraform.workspace}"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.public_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name"        = "${terraform.workspace}-public-rt"
    "Environment" = "${terraform.workspace}"
  }
}


resource "aws_route_table_association" "Public_RT_Association" {
    count = length(var.public_subnet_ids)
    subnet_id = var.public_subnet_ids[count.index]
    route_table_id = aws_route_table.public-RT.id
  
}


resource "aws_eip" "private_eip" {
    domain = "vpc"  
}

resource "aws_nat_gateway" "nat_GW" {
  allocation_id = aws_eip.private_eip.id
  subnet_id = var.public_subnet_ids[0]
  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_route_table" "private-RT" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.public_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_GW.id
  }
  tags = {
    "Name"        = "${terraform.workspace}-private-RT"
    "Environment" = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "Private_RT_Association" {
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private-RT.id
  
}