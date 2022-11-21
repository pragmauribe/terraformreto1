# Key_Pair
resource "aws_key_pair" "ec2_Key" {
  key_name   = "ec2_key"
  public_key = file("${path.module}/ec2_key.pem.pub")
}

# EC2 Public
resource "aws_instance" "app_server1" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.Subnet_Public.id
  security_groups = [aws_security_group.SecGruPub.id]
  key_name        = "ec2_key"
  iam_instance_profile = aws_iam_instance_profile.admin-resources-iam-profile.name
  # security_groups = [aws_security_group.Public_SG[count.index].name]
  # security_groups = [aws_security_group.]
  # Count permite crear el número de instancias necesarias
  #count = 2

  user_data = <<EOF
  #! /bin/bash
  sudo apt-get update
  sudo apt install -y apache2
  echo "The page was created by the user data" | sudo tee /var/www/html/index.html
  EOF

  # En el tag nombre se usa el index para asignar a cada instancia un valor [1 ,2]  
  tags = {
    Name  = var.EC2Names[0]
    owner = "ivan.uribe@pragma.com.co"
    stack = "Pruebas"
  }
}

# EC2 Private
resource "aws_instance" "app_server2" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.Subnet_Private.id
  security_groups      = [aws_security_group.SecGruPri.id]
  key_name             = "ec2_key"
  iam_instance_profile = aws_iam_instance_profile.admin-resources-iam-profile.name
  # security_groups = [aws_security_group.Public_SG[count.index].name]
  # security_groups = [aws_security_group.]
  # Count permite crear el número de instancias necesarias
  # count = 2
  user_data = <<EOF
  #!/bin/bash
  sudo mkdir /tmp/ssm
  cd /tmp/ssm
  wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
  sudo dpkg -i amazon-ssm-agent.deb
  sudo systemctl enable amazon-ssm-agent
  rm amazon-ssm-agent.deb
  EOF

  # En el tag nombre se usa el index para asignar a cada instancia un valor [1 ,2]  
  tags = {
    Name  = var.EC2Names[1]
    owner = "ivan.uribe@pragma.com.co"
    stack = "Pruebas"
  }
}