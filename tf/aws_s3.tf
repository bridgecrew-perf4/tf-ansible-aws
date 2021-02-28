resource "aws_s3_bucket" "wp-data-s3-bucket" {
  bucket = var.s3_bucket
  acl = "private"
  force_destroy = var.is_production ? false : true
  versioning {
    enabled = false
  }


  tags = {
    Name = "db ${var.env} for ${var.project}"
    Env = var.env
  }

}