
![alt text](https://github.com/hanov/tf-ansible-aws/blob/master/aws.jpg?raw=true)

variables 
 - wp-content-terraform-bucket
 - mysql host 
 - mysql pass




 make tags


## Prerequisites:
1. installed aws cli
```
aws --version
aws-cli/2.0.40 Python/3.7.4 Darwin/19.6.0 exe/x86_64
```

2. configured aws creds in ~/.aws/credentials
```
[home]
aws_access_key_id = AKIAxxxxxxxxxx37GTN5
aws_secret_access_key = uiWxxxxxxxxxxxxxxxxxxxxBMi
```

3. installed terraform 
```
tf -version
Terraform v0.12.24
+ provider.aws v3.30.0
```

3. installed ansible 
```
ansible --version
ansible 2.10.3
```

4. make sure you have public key located in 
```
~/.ssh/id_rsa.pub
```
if not then generate it with command ssh-keygen
```
ssh-keygen
```

5. create key pair in aws
```
aws --profile home ec2 import-key-pair --key-name "user-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub
```

## Make it great again:
6. finally run terraform
```
terraform init 
terraform plan -var-file="env_vars/$(terraform workspace show).tfvars" 
terraform apply -var-file="env_vars/$(terraform workspace show).tfvars" 
```

result will be looks like next:
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

alb_address = tf-alb-53172144.eu-central-1.elb.amazonaws.com
frontend_blue_ip = 10.0.2.237
frontend_green_ip = 10.0.2.56
jumpbox_ip = 52.59.244.211
rds_endpoint = terraform-20210228221713366700000001.cvqrmnslrfgx.eu-central-1.rds.amazonaws.com:3306
```

7. [TODO] implement tempalte generation for ansible variable and hosts inventory 

8. Since 7th item is not here yet we need to manually edit inventory and variables
```
cat ansible/hosts
[front]
server_green ansible_host=10.0.2.56 ansible_user=ubuntu ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ubuntu@52.59.244.211"'
#server_blue ansible_host=10.0.2.237 ansible_user=ubuntu ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ubuntu@52.59.244.211"'

[jump]
jumpbox ansible_host=52.59.244.211 ansible_user=ubuntu
```

9. Edit ansible vars from tf/env_vars/default.tfvars
```
cat tf/env_vars/default.tfvars

is_production = false
aws_region = "eu-central-1"
aws_profile = "home"
env = "sandbox"

# 4gb 2vcpu 
instance_type = "t3a.medium"

# aws --profile home ec2 import-key-pair --key-name "user-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub
ec2_key_name = "user-personal-key"

# ubuntu 20
ec2_ami = "ami-0502e817a62226e03"

s3_bucket = "wp-data-sand-202003270001"

# sand instance 
rds_instance_type = "db.t3.micro"

rds_db_size = 20
rds_db_name = "wpdb"
rds_db_user = "admin"
rds_db_pass = "qwerty1234"
```

