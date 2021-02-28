
resource "aws_security_group" "allow_web_alb" {
  name        = "allow_web_alb"
  description = "Allow web inbound traffic and ssh from internal network"
  vpc_id      = aws_vpc.vpc.id

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

















resource "aws_lb_target_group" "aws_lb_tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "tg ${var.env} for ${var.project}"
    Env = var.env
  }

}

resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.aws_lb_tg.arn
  target_id        = aws_instance.frontend_green.id 
  port             = 80

}

# resource "aws_lb_target_group_attachment" "my-alb-target-group-attachment2" {
#   target_group_arn = "${aws_lb_target_group.my-target-group.arn}"
#   target_id        = "${var.instance2_id}"
#   port             = 80
# }

resource "aws_lb" "alb" {
  name     = "tf-alb"
  internal = false

  security_groups = [
    aws_security_group.allow_web_alb.id,
  ]

  subnets = [
    aws_subnet.priv_subnet.id,
    aws_subnet.pub_subnet.id
  ]

  tags = {
    Name = "alb ${var.env} for ${var.project}"
    Env = var.env
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_tg.arn
  }

}

