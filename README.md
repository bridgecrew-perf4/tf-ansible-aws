
## Introduction:

This repo is configured to provision basic AWS infrastructure and configure blue/green deployment of the wp engine. AWS VPC is designed with two subnets as shown in the picture below. All resources are placed in a private subnet for the sake of security. The only resource that can be accessed directly is the jump host. Jump host can be configured to whitelist IP for connection via security groups. It's a good practice to put jump host behind VPN. All frontend requests are routed via ALB. The database is provisioned by AWS RDS and located in the private subnet as well. The problem of persistent data is solved by syncing wp-data to the s3 bucket with crontab.  

All resources are tagged and those tags can be used in the future like for example cost management. It's a good idea to know how much cost spent per environment or a specific user. 
```
  tags = {
    Name = "alb ${var.env} for ${var.project}"
    Env = var.env
  }
```

It is feasible to provision a sandbox/staging/production environment. Sandbox and staging easy to create and destroy. Production one has constraints for accidental removal.
```
# s3 and rds is protected from accidental removal
is_production = true

...

force_destroy = var.is_production ? false : true

...

deletion_protection         = var.is_production ? true : false
```



![alt text](https://github.com/hanov/tf-ansible-aws/blob/master/aws.jpg?raw=true)


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


10. run ansible playbook
```
cd ansible
ansible-playbook -i hosts playbook.yml

PLAY [jump] **************************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [jumpbox]

TASK [put the key on the jump box to access internal resources] **********************************************************************************************************************
ok: [jumpbox] => (item=~/.ssh/id_rsa.pub)
ok: [jumpbox] => (item=~/.ssh/id_rsa)

PLAY [front] *************************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [server_green]

TASK [Install prerequisites] *********************************************************************************************************************************************************
ok: [server_green]

TASK [install awscli] ****************************************************************************************************************************************************************
ok: [server_green]

TASK [Install LAMP Packages] *********************************************************************************************************************************************************
ok: [server_green] => (item=apache2)
ok: [server_green] => (item=python3-pymysql)
ok: [server_green] => (item=php)
ok: [server_green] => (item=php-mysql)
ok: [server_green] => (item=libapache2-mod-php)

TASK [Install PHP Extensions] ********************************************************************************************************************************************************
ok: [server_green] => (item=php-curl)
ok: [server_green] => (item=php-gd)
ok: [server_green] => (item=php-mbstring)
ok: [server_green] => (item=php-xml)
ok: [server_green] => (item=php-xmlrpc)
ok: [server_green] => (item=php-soap)
ok: [server_green] => (item=php-intl)
ok: [server_green] => (item=php-zip)

TASK [Create document root] **********************************************************************************************************************************************************
ok: [server_green]

TASK [Set up Apache VirtualHost] *****************************************************************************************************************************************************
ok: [server_green]

TASK [Enable rewrite module] *********************************************************************************************************************************************************
changed: [server_green]

TASK [Enable new site] ***************************************************************************************************************************************************************
changed: [server_green]

TASK [Disable default Apache site] ***************************************************************************************************************************************************
changed: [server_green]

TASK [UFW - Allow HTTP on port 80] ***************************************************************************************************************************************************
ok: [server_green]

TASK [Download and unpack latest WordPress] ******************************************************************************************************************************************
skipping: [server_green]

TASK [Sync persistent data from s3] **************************************************************************************************************************************************
[WARNING]: Consider using 'become', 'become_method', and 'become_user' rather than running sudo
changed: [server_green]

TASK [sync data folder every minute] *************************************************************************************************************************************************
changed: [server_green]

TASK [Set ownership] *****************************************************************************************************************************************************************
changed: [server_green]

TASK [Set permissions for directories] ***********************************************************************************************************************************************
changed: [server_green]

TASK [Set permissions for files] *****************************************************************************************************************************************************
changed: [server_green]

TASK [Set up wp-config] **************************************************************************************************************************************************************
changed: [server_green]

RUNNING HANDLER [Reload Apache] ******************************************************************************************************************************************************
changed: [server_green]

RUNNING HANDLER [Restart Apache] *****************************************************************************************************************************************************
changed: [server_green]

PLAY RECAP ***************************************************************************************************************************************************************************
jumpbox                    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
server_green               : ok=19   changed=11   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   


```

11. open alb endpoint and observe working deployment
```
alb_address = tf-alb-53172144.eu-central-1.elb.amazonaws.com
```


12. [TODO] describe seamless blue/green depyment

13. remove all resosurces
```
terraform destroy -var-file="env_vars/$(terraform workspace show).tfvars" 
```

14. deploy production
```
terraform workspace new production
terraform plan -var-file="env_vars/$(terraform workspace show).tfvars" 
terraform apply -var-file="env_vars/$(terraform workspace show).tfvars" 
```


## Room for improvments:
1. templater for ansible vars and hosts
2. s3 sync for tf state file
3. create separate ssh key for jump box
4. wrap tf files to modules
5. implement secret managment for credentails
6. golden ami preparation 
7. aws launch template creation
8. configuring autoscaling group
9. build the pipeline for jenkins 
10. stream logs to cloudwatch 
11. configure auditd on jump host
12. fail2ban on jump host
13. sequrity group for jump host based on vpn ip
14. vpn server
15. add owner to tags
16. fault tolerancy with two private subntents in different az and multi az database.