
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



