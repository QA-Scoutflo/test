data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = local.tags
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = local.tags
}

data "aws_availability_zones" "available" {}

resource "aws_security_group" "ec2" {
  name        = "${local.name_prefix}-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from allowed CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_iam_role" "ec2" {
  name = "${local.name_prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  tags = local.tags
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "ec2_least_privilege" {
  name = "${local.name_prefix}-least-privilege"
  role = aws_iam_role.ec2.id
  policy = data.aws_iam_policy_document.least_privilege.json
}

data "aws_iam_policy_document" "least_privilege" {
  statement {
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${local.name_prefix}-profile"
  role = aws_iam_role.ec2.name
}

resource "aws_instance" "main" {
  ami                         = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux2.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2.name

  root_block_device {
    encrypted   = true
    volume_size = 20
    volume_type = "gp3"
  }

  tags = local.tags
}
