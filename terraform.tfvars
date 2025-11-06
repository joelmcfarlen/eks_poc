

// ROOT TFVARS


// Environment

aws_region            =   "us-east-1"
environment           =   "demo"
project               =   "cogspace"
alb_certificate_arn   =   "arn:aws:acm:us-east-1:901207487591:certificate/9cfaa111-67bd-42ea-945f-1f3d68cf66fe"


// Networking

vpc           =   "vpc-0d45f238af573b647"
subnet_pv_1   =   "subnet-04c6f9730eaf5ca47"
subnet_pv_2   =   "subnet-01d438f9715a10863"
subnet_pv_3   =   "subnet-054aa43d0bee16380"
subnet_pub_1  =   "subnet-071bfa86885bde7c9"
subnet_pub_2  =   "subnet-04efe776a30d2ddf5"
subnet_pub_3  =   "subnet-00a619f063f3cca54"


// EKS

node_group_ami_type       =   "AL2023_x86_64_STANDARD"
node_group_instance_type  =   ["t3.micro"]
node_group_desired_size   =   4
node_group_min_size       =   2
node_group_max_size       =   6
