
resource "aws_instance" "jumpbox"{
  
  ami = var.ec2_ami

  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = var.ec2_key_name
  subnet_id = aws_subnet.pub_subnet.id

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = "true"
  }

  tags = {
    Name = "jumpbox ${var.env} for ${var.project}"
    Env = var.env
  }

}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.vpc.id




ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["79.173.147.118/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}




resource "aws_instance" "cassandra_1a"{

  ami = var.ec2_ami

  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  key_name = var.ec2_key_name
  subnet_id = aws_subnet.priv_subnet.id

  root_block_device {
    volume_type = "gp2"
    volume_size = 500
    delete_on_termination = "true"
  }

  tags = {
    Name = "cassandra_1a ${var.env} for ${var.project}"
    Env = var.env
  }
  
}



resource "aws_instance" "cassandra_1b"{

  ami = var.ec2_ami
  
  instance_type = var.instance_type  
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  
  key_name = var.ec2_key_name
  subnet_id = aws_subnet.priv_subnet.id

  root_block_device {
    volume_type = "gp2"
    volume_size = 500
    delete_on_termination = "true"
  }

  tags = {
    Name = "cassandra_1b ${var.env} for ${var.project}"
    Env = var.env
  }

}




resource "aws_instance" "cassandra_1c"{

  ami = var.ec2_ami
  
  instance_type = var.instance_type  
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  
  key_name = var.ec2_key_name
  subnet_id = aws_subnet.priv_subnet.id

  root_block_device {
    volume_type = "gp2"
    volume_size = 500
    delete_on_termination = "true"
  }

  tags = {
    Name = "cassandra_1b ${var.env} for ${var.project}"
    Env = var.env
  }

}


resource "aws_security_group" "allow_web_ssh" {
  name        = "allow_all_internal"
  description = "Allow all inbound traffic in internal network"
  vpc_id      = aws_vpc.vpc.id


# ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.vpc.cidr_block]
#   }

ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
