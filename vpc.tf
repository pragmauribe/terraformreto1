# VPC
resource "aws_vpc" "VPC_Pragma" {
  cidr_block           = var.CIDR_VPC[0]
  enable_dns_hostnames = true

  tags = {
    Name = "VPC_Pragma"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw_Pragma" {
  vpc_id = aws_vpc.VPC_Pragma.id

  tags = {
    Name = "Gateway_Pragma"
  }
}

/*
# Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "gwa" {
  internet_gateway_id = aws_internet_gateway.gw_Pragma.id
  vpc_id              = aws_vpc.VPC_Pragma.id
}*/