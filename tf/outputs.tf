
output "jumpbox_ip" {
  value = aws_instance.jumpbox.public_ip
}

output "frontend_blue_ip" {
  value = aws_instance.frontend_blue.private_ip
}

output "frontend_green_ip" {
  value = aws_instance.frontend_green.private_ip
}

output "alb_address" {
   value = aws_lb.alb.dns_name
 }

output "rds_endpoint" {
   value = aws_db_instance.my_test_mysql.endpoint
 }

output "rds_db_pass" {
   value = var.rds_db_pass
}

output "rds_db_name" {
   value = var.rds_db_name
}

output "rds_db_user" {
   value = var.rds_db_user
}

output "s3_bucket" {
   value = var.s3_bucket
}




#  #MySQL Settings
# mysql_root_password: "${rds_db_pass}"
# mysql_db: "${rds_db_name}"
# mysql_user: "${rds_db_user}"
# mysql_password: "${rds_db_pass}"
# mysql_host: "${rds_endpoint}"

# # s3 storage
# s3_bucket: "${s3_bucket}"



