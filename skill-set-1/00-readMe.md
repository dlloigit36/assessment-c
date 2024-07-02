### skill set 1 assessemnt only manage to do until ALB default dns name access, forward http request to back-end target group
### with ec2 registered into target group running gitea application started with docker-compose

1. build a custom AMI with gitea running (started by docker-compose). Details see folder ./ami-gitea/00-readMe.md
2. build AWS VPC with terraform file in folder ./vpc-1 this is to create
    - vpc
    - public subnets and private subnets
    - security group
3. build AWS ec2 install with terraform files in folder ./ec2-1 this is to create a ec2 instance (build from custom AMI) running application gitea
4. build AWS ALB and target-group with terraform files in folder ./alb-2