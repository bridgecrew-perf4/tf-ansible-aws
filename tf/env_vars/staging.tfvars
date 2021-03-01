#terraform plan -var-file="env_vars/$(terraform workspace show).tfvars"

# s3 and rds is protected from accidental removal
is_production = false

aws_region = "eu-central-1"

aws_profile = "home"

env = "staging"

# 16gb 4vcpu t3a.xlarge
# 32gb 8vcpu t3a.2xlarge
instance_type = "t3a.large"


# aws --profile home ec2 import-key-pair --key-name "user-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub
ec2_key_name = "user-personal-key"

# ubuntu 20
ec2_ami = "ami-0502e817a62226e03"


# must be unique
s3_bucket = "wp-data-staging-202003270001"


# db.r6g.large	-	cpu 2	ram 16
# db.r6g.16xlarge	- cppu	64	ram 512
# db.t3.xlarge vcpu  4 ram 16 
rds_instance_type = "db.t3.xlarge"

rds_db_size = 100
rds_db_name = "wpdb"
rds_db_user = "admin"
rds_db_pass = "qwerty1234"