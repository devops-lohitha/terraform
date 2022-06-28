resource "aws_vpc" "dev_vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev_vpc"
  }
}



resource "aws_subnet" "dev_pub_sub_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.10.6.0/24"

  tags = {
    Name = "dev_pub_sub_1"
  }
}


resource "aws_subnet" "dev_prv_sub_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.10.100.0/24"

  tags = {
    Name = "dev_prv_sub_1"
  }
}

resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_IGW.id
  }
  
  

  tags = {
    Name = "dev_pub_rt"
  }
}


resource "aws_route_table" "dev_prv_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route = []

  tags = {
    Name = "dev_prv_rt"
  }
}




resource "aws_route_table_association" "pubrt_pub_sub" {
  subnet_id      = aws_subnet.dev_pub_sub_1.id
  route_table_id = aws_route_table.dev_public_rt.id

}





resource "aws_route_table_association" "prv_rt_prv_sub_ass" {
  subnet_id      = aws_subnet.dev_prv_sub_1.id
  route_table_id = aws_route_table.dev_prv_rt.id
}





resource "aws_internet_gateway" "dev_IGW" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_vpc_igw"
  }
}




resource "aws_nat_gateway" "dev" {
  allocation_id = aws_eip.T_eip.id
  subnet_id     = aws_subnet.dev_pub_sub_1.id

  tags = {
    Name = "dev_nat"
  }
}




resource "aws_eip" "T_eip" {
  vpc = true
  tags = {
    name = "terraform_EIP"
  }
}
