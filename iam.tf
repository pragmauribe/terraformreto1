# Resource: AWS_IAM_Group
# Provides an IAM group
/*resource "aws_iam_group" "administrators" {
  name = "administrators"
}*/

# aws_iam_policy_attachment
# Attaches a Managed IAM Policy to user(s), role(s), and/or group(s)
/*esource "aws_iam_policy_attachment" "admon-attach" {
  name = "admon-attachment"
  # users      = [aws_iam_user.ivan.gonzalez.name]
  # roles      = [aws_iam_role.role.name]
  groups     = [aws_iam_group.administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}*/

# Resource: aws_iam_user
# Provides an IAM user
/*resource "aws_iam_user" "iam_user" {
  name = "Systems_Manager"
  tags = {
    name = "User Systems Manager"
  }
}*/

# Resource: aws_iam_user_group_membership
# Provides a resource for adding an IAM User to IAM Groups. This resource can be used multiple times with the same user for non-overlapping groups
/*resource "aws_iam_user_group_membership" "member" {
  user = aws_iam_user.iam_user.name

  groups = [
    aws_iam_group.administrators.name
  ]
}*/

# Resource: aws_iam_access_key
# Provides an IAM access key. This is a set of credentials that allow API requests to be made as an IAM user
/*resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.iam_user.name
}*/

# Resource: aws_iam_role
# Provides an IAM role
resource "aws_iam_role" "admin-iam-role" {
  name               = "EC2-ssm-role"
  description        = "The role for the admin resources EC2"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
  "Statement": {
  "Effect": "Allow",
  "Principal": {"Service": "ec2.amazonaws.com"},
  "Action": "sts:AssumeRole"}
  }
  EOF
  tags = {
    stack = "test"
  }
}

# Resource: aws_iam_role_policy_attachment
# Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "admin-resources-ssm-policy1" {
  role       = aws_iam_role.admin-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "admin-resources-ssm-policy2" {
  role       = aws_iam_role.admin-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "admin-resources-ssm-policy3" {
  role       = aws_iam_role.admin-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "admin-resources-ssm-policy4" {
  role       = aws_iam_role.admin-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}



# Resource: aws_iam_instance_profile
# Provides an IAM instance profile
resource "aws_iam_instance_profile" "admin-resources-iam-profile" {
  name = "ec2_profile"
  role = aws_iam_role.admin-iam-role.name
}

# Outputs
/*output "iam_user_access_key" {
  value = aws_iam_access_key.lb.id
}

data "template_file" "secret" {
  template = aws_iam_access_key.lb.secret
}

output "iam_user_secret_key" {
  value = data.template_file.secret.rendered
}*/