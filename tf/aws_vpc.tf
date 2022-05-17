
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc ${var.env} for ${var.project}"
    Env = var.env
  }

}



resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "public_subnet for ${var.project}"
    Env = var.env
  }

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw ${var.env} for ${var.project}"
    Env = var.env
  }
}


resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "default route table ${var.env} for ${var.project}"
    Env = var.env
  }
}













resource "aws_subnet" "priv_subnet" {

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.pub_subnet
  ]

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}b"
  #availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "private_subnet for ${var.project}"
    Env = var.env
  }

}


resource "aws_eip" "nat_gw_eip" {
  depends_on = [
    aws_default_route_table.route_table
  ]
  vpc = true

  tags = {
    Name = "eip ${var.env} for ${var.project}"
    Env = var.env
  }
}



resource "aws_nat_gateway" "nat_gw" {
  depends_on = [
    aws_eip.nat_gw_eip
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.nat_gw_eip.id
  
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.pub_subnet.id

  tags = {
    Name = "NAT GW for priv subnt in pub subnet for ${var.project}"
    Env = var.env
  }
}




# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "nat_gw_rt" {
  depends_on = [
    aws_nat_gateway.nat_gw
  ]

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Route Table for NAT Gateway for ${var.project}"
    Env = var.env
  }

}



resource "aws_route_table_association" "nat_gw_rt_accos" {
  depends_on = [
    aws_route_table.nat_gw_rt
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.priv_subnet.id

# Route Table ID
  route_table_id = aws_route_table.nat_gw_rt.id

  
}











