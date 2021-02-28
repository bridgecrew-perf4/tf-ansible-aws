

resource "aws_db_subnet_group" "rds-private-subnet" {
  name = "rds-private-subnet-group"
  subnet_ids = [aws_subnet.priv_subnet.id, aws_subnet.pub_subnet.id]
}


resource "aws_security_group" "rds-sg" {
  name   = "my-rds-sg"
  vpc_id = aws_vpc.vpc.id

}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds-sg.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}



resource "aws_db_instance" "my_test_mysql" {
  allocated_storage           = var.rds_db_size
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = var.rds_instance_type
  name                        = var.rds_db_name
  username                    = var.rds_db_user
  password                    = var.rds_db_pass
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = aws_db_subnet_group.rds-private-subnet.name
  vpc_security_group_ids      = [aws_security_group.rds-sg.id]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = false
  skip_final_snapshot         = var.is_production ? false : true
  deletion_protection         = var.is_production ? true : false


  tags = {
    Name = "db ${var.env} for ${var.project}"
    Env = var.env
  }

}




