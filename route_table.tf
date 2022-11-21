# AWS Public Route Table
# Permitir todo el tráfico de Entrada al Internet_Gateway
resource "aws_route_table" "RT_Public" {
  vpc_id = aws_vpc.VPC_Pragma.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_Pragma.id
  }
  tags = {
    Name = var.RouteTable[0]
  }
}

# AWS Private Route Table
# Permitir todo el tráfico de Entrada al NAT_Gateway
resource "aws_route_table" "RT_Private" {
  vpc_id = aws_vpc.VPC_Pragma.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id

  }
  tags = {
    Name = var.RouteTable[1]
  }
}

# AWS Main Route_Table Association
# Provides a resource for managing the main routing table of a VPC
/*resource "aws_route_table_association" "a" {
  subnet_id         = aws_subnet.Subnet_Private.id
  route_table_id = aws_route_table.RT_Private.id
}*/

# AWS Route Table Association
# Public Subnet
resource "aws_route_table_association" "Public_Subnet" {
  subnet_id      = aws_subnet.Subnet_Public.id
  route_table_id = aws_route_table.RT_Public.id
}

# Private Subnet
resource "aws_route_table_association" "Private_Subnet" {
  subnet_id      = aws_subnet.Subnet_Private.id
  route_table_id = aws_route_table.RT_Private.id
}