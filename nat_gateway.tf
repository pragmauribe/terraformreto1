# Resource: aws_nat_gateway
# Provides a resource to create a VPC NAT Gateway

# Private NAT
resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.Subnet_Public.id
  allocation_id = aws_eip.lb.id

  tags = {
    Name  = "NAT_Gateway"
    owner = "ivan.uribe@pragma.com.co"
    stack = "Pruebas"
  }
}

resource "aws_eip" "lb" {
  #instance = aws_instance.web.id
  vpc      = true
}