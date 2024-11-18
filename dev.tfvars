################## Global Variables ############
region      = "us-east-1"
project     = "k8s"
environment = "dev"
createdby   = "parag"
owner       = "Parag"
management  = "terraform"

terraform_state_bucket_bucket_name = "terraform-k8s"
terraform_state_bucket_bucket_key  = "dev/terraform.tfstate"

############# VPC Variables ##################

vpc_cidr           = "194.168.0.0/16"
enable_nat_gateway = true
subnets = [
  { subnet_name = "eks-subnet-2a", cidr_block = "194.168.0.0/22", az = "us-east-1a", type = "private", nacl = "eks" },
  { subnet_name = "eks-subnet-2b", cidr_block = "194.168.4.0/22", az = "us-east-1b", type = "private", nacl = "eks" },
  { subnet_name = "db-subnet-2a", cidr_block = "194.168.8.0/24", az = "us-east-1a", type = "private", nacl = "db" },
  { subnet_name = "db-subnet-2b", cidr_block = "194.168.9.0/24", az = "us-east-1b", type = "private", nacl = "db" },
  { subnet_name = "public-subnet-2a", cidr_block = "194.168.11.0/25", az = "us-east-1a", type = "public", nacl = "public" },
  # { subnet_name = "nat-subnet-2a",    cidr_block = "194.168.12.0/25",   az = "us-east-1a", type="public" , nacl="nat"},
  # { subnet_name = "nat-subnet-2b",    cidr_block = "194.168.12.128/25", az = "us-east-1b", type="public" , nacl="nat"},
]


nacl_rules = []

#eks
eks_kube_version = "1.27"


eks_service_node_group = {
  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  desired_size   = 3
  disk_size      = 100
  instance_types = ["t3.xlarge"]
  max_size       = 3
  min_size       = 1
  labels = {
    "Tier"      = "backend",
    "Component" = "api",
  }
}