
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}




resource "aws_instance" "frontend_blue"{

  ami = var.ec2_ami

  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  key_name = var.ec2_key_name
  subnet_id = aws_subnet.priv_subnet.id

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    delete_on_termination = "true"
  }

  tags = {
    Name = "frontend_blue ${var.env} for ${var.project}"
    Env = var.env
  }
  
}



resource "aws_instance" "frontend_green"{

  ami = var.ec2_ami
  
  instance_type = var.instance_type  
  vpc_security_group_ids = [aws_security_group.allow_web_ssh.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  
  key_name = var.ec2_key_name
  subnet_id = aws_subnet.priv_subnet.id

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    delete_on_termination = "true"
  }

  tags = {
    Name = "frontend_green ${var.env} for ${var.project}"
    Env = var.env
  }

}



resource "aws_security_group" "allow_web_ssh" {
  name        = "allow_web"
  description = "Allow web inbound traffic and ssh from internal network"
  vpc_id      = aws_vpc.vpc.id


ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
