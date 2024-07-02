module "ec2_c-web1" {
  source  = "../terraform-aws-ec2-instance-master"

  name = "c-web1"

  instance_type          = "t2.micro"
  key_name               = "aws-key"
  monitoring             = false
  # security group id and subnet id need to be change if vpc module rebuild
  vpc_security_group_ids = ["sg-03d0b7017f45150d1"]
  subnet_id              = "subnet-04584f37416e0ecce"

#   custom image Ubuntu 24.04 LTS with docker installed and running gitae, need to be change if image rebuild
  ami = "ami-0eacc483a9bd370db"

  tags = {
    Terraform   = "true"
    Environment = "Dev"
    Project     = "c1"
  }
}