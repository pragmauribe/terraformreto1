# Public Subnet
resource "aws_subnet" "Subnet_Public" {
  vpc_id     = aws_vpc.VPC_Pragma.id
  cidr_block = var.CIDR_Public[0]
  # cidr_block = "10.0.1.0/24"
  # Asignación automática de IP
  map_public_ip_on_launch = true
  # AZ or the subnet (Optional)
  availability_zone = var.availability_zone[0]
  # us-west-2a
  # count = 2

  tags = {
    Name = var.Subnet_Public[0]
    # Public Subnet
  }
}

# Private Subnet
resource "aws_subnet" "Subnet_Private" {
  vpc_id     = aws_vpc.VPC_Pragma.id
  cidr_block = var.CIDR_Private[1]
  # cidr_block = "10.0.2.0/24"
  # Asignación automática de IP
  map_public_ip_on_launch = false
  # AZ or the subnet (Optional)
  availability_zone = var.availability_zone[1]
  # us-west-2a
  # count = 2
  tags = {
    Name = var.Subnet_Private[1]
    # Private Subnet
  }
}

# # Subnets
# resource "aws_subnet" "Subnet" {
#   vpc_id     = aws_vpc.VPC_Pragma.id
#   cidr_block = var.CIDR[count.index]
#   # Asignación automática de IP Pública
#   /*variable "network" {
#   }
#   var.network == "Subnet_Public" ? map_public_ip_on_launch = true : map_public_ip_on_launch = false*/
#   map_public_ip_on_launch = true
#   # AZ or the subnet (Optional)
#   availability_zone = "us-west-2a"
#   count = 2
#   tags = {
#     Name = var.Subnet[count.index]
#   }
# }

# AWS Network ACL_Association
# Provides an network ACL association resource which allows you to associate your network ACL with any subnet(s)
/*
resource "aws_network_acl_association" "ACL_Public" {
  network_acl_id = aws_network_acl.ACL_Public.id
  subnet_id      = aws_subnet.Subnet_Public.id
}

resource "aws_network_acl_association" "ACL_Private" {
  network_acl_id = aws_network_acl.ACL_Private.id
  subnet_id      = aws_subnet.Subnet_Private.id
}*/