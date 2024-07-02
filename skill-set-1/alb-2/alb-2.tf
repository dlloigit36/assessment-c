resource "aws_lb" "front_end" {
  name               = "test-alb-tf"
  internal           = false
  load_balancer_type = "application"
  # security group id and subnet id need to be change if vpc-1 rebuild
  security_groups    = ["sg-03d0b7017f45150d1"]
  subnets            = ["subnet-04584f37416e0ecce", "subnet-0234425f8b076b75b"]
  ip_address_type = "ipv4"

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
    Project = "c1"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-c.arn
  }

  depends_on = [ aws_lb.front_end ]
}