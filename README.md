

aws s3 sync /var/www/your_domain/wordpress/wp-content s3://wp-content-terraform-bucket

sudo aws s3 sync s3://wp-content-terraform-bucket /var/www/your_domain/wordpress/wp-content


* * * * * aws s3 sync /var/www/your_domain/wordpress/wp-content s3://wp-content-terraform-bucket


![alt text](https://github.com/hanov/tf-ansible-aws/blob/master/aws.jpg?raw=true)

variables 
 - wp-content-terraform-bucket
 - mysql host 
 - mysql pass




 make tags


prerequsties:
1. installed aws cli
aws --version
aws-cli/2.0.40 Python/3.7.4 Darwin/19.6.0 exe/x86_64


2. configured aws creds in ~/.aws/credentials

[home]
aws_access_key_id = AKIAxxxxxxxxxx37GTN5
aws_secret_access_key = uiWxxxxxxxxxxxxxxxxxxxxBMi


3. installed terraform 
tf -version
Terraform v0.12.24
+ provider.aws v3.30.0

3. installed ansible 
ansible --version
ansible 2.10.3



steps to create infrastructure:

0. make sure you have public key located in ~/.ssh/id_rsa.pub
   if not then generate it with command ssh-keygen

1. create key pair in aws
aws --profile home ec2 import-key-pair --key-name "$LOGNAME-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub

aws --profile home ec2 import-key-pair --key-name "user-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub

now we can log on jump box 

2. 

