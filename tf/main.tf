provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}



data "template_file" "dev_hosts" {
  template = "${file("${path.module}/tpl/ansible_inventory.cfg")}"
  
  vars = {
    blue = aws_instance.frontend_blue.private_ip
    green = aws_instance.frontend_green.private_ip
    jump = aws_instance.jumpbox.public_ip
  }
}

resource "null_resource" "dev-hosts" {
  triggers = {
    template_rendered = "${data.template_file.dev_hosts.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.dev_hosts.rendered}' > ../ansible/provisioned_hosts"
  }
}


# module "aws_vpc" {
#   source = "./modules/aws_vpc"

#   # droplet_count = 3
#   # group_name    = "group1"
# }
