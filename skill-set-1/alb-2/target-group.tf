# get target ec2 instance to be registered into target group
data "aws_instance" "c-web1" {
  # ec2 instance id need to be change if ec2 rebuild
  instance_id = "i-087a99f65175749f1"
}

# create alb target group
resource "aws_lb_target_group" "alb-c" {
  name        = "tg-alb-c-1"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  # vpc id need to be change if vpc rebuild
  vpc_id      = "vpc-0c0cd5105979af8e7"
  protocol_version = "HTTP1"
  ip_address_type = "ipv4"

  health_check {
    enabled = true
    path = "/"
    timeout = 5
    interval = 30
    protocol = "HTTP"
    matcher = "200"
  }
  
}

# register instance into target group
resource "aws_lb_target_group_attachment" "c-web1" {
  target_group_arn = aws_lb_target_group.alb-c.arn
  target_id        = data.aws_instance.c-web1.id
  port             = 8080
  depends_on = [ aws_lb_target_group.alb-c, data.aws_instance.c-web1 ]
}


