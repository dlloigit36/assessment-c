module "vpc-172-17" {
  source = "../terraform-aws-vpc-master"

  name = "my-vpc-172-17"
  cidr = "172.17.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets = ["172.17.1.0/24", "172.17.2.0/24"]
  public_subnets  = ["172.17.101.0/24", "172.17.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  # enabled public IP allocation to ec2 instance
  map_public_ip_on_launch = true

  # use one security group for ec2 access and ALB access to simplying setup
  default_security_group_name = "my-default-sg-1"
  default_security_group_ingress = [
      {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh-port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http-port"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  default_security_group_egress = [
    {
      rule        = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },

  ]



  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}