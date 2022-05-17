# terraform plan -var-file="env_vars/$(terraform workspace show).tfvars"

is_production = false

aws_region = "eu-central-1"

aws_profile = "home"

project = "cassandra-plain"

env = "sandbox-cassandra-plain"

# 4gb 2vcpu 
instance_type = "t3a.medium"

# aws --profile home ec2 import-key-pair --key-name "user-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub
# paycasso_2016
ec2_key_name = "user-personal-key"


ec2_ami = "ami-09439f09c55136ecf"


s3_bucket = "wp-data-sand-202003270001"


# sand instance 
rds_instance_type = "db.t3.micro"

rds_db_size = 20
rds_db_name = "wpdb"
rds_db_user = "admin"
rds_db_pass = "qwerty1234"
