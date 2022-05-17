
output "jumpbox_ip" {
  value = aws_instance.jumpbox.public_ip
}

output "cassandra_1a" {
  value = aws_instance.cassandra_1a.private_ip
}

output "cassandra_1b" {
  value = aws_instance.cassandra_1b.private_ip
}

output "cassandra_1c" {
  value = aws_instance.cassandra_1c.private_ip
}





#  #MySQL Settings
# mysql_root_password: "${rds_db_pass}"
# mysql_db: "${rds_db_name}"
# mysql_user: "${rds_db_user}"
# mysql_password: "${rds_db_pass}"
# mysql_host: "${rds_endpoint}"

# # s3 storage
# s3_bucket: "${s3_bucket}"



