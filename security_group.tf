resource "aws_security_group" "SecGruPub" {
  name        = "SG_Public_Network"
  description = "Allow Public Inbound Traffic"
  vpc_id      = aws_vpc.VPC_Pragma.id

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic egress {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = var.SecGroup[0]
  }
}

resource "aws_security_group" "SecGruPri" {
  name        = "SG_Private_Network"
  description = "Allow Private Inbound Traffic"
  vpc_id      = aws_vpc.VPC_Pragma.id

  ingress {
    description = "Allow Trafic Public Subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #cidr_blocks      = ["10.0.1.0/24"]
    security_groups = [aws_security_group.SecGruPub.id]
    # Permitir tráfico de la Red Pública
  }

  /*ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }*/

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.SecGroup[1]
  }
}