
module "vpc" {
  source             = "./modules/vpc"
  project            = var.project
  environment        = var.environment
  owner              = var.owner
  management         = var.management
  createdby          = var.createdby
  vpc_cidr           = var.vpc_cidr
  subnets            = var.subnets
  enable_nat_gateway = var.enable_nat_gateway
}
module "eks" {
  source             = "./modules/eks"
  project            = var.project
  environment        = var.environment
  owner              = var.owner
  management         = var.management
  createdby          = var.createdby
  key_name_eks       = "${lower(join("-", [var.project, var.environment,"eks-node"]))}-private-key"
  eks_kube_version   = var.eks_kube_version
  service_node_group = var.eks_service_node_group
  public_sub_ids     = module.vpc.public_subnet_ids
  private_sub_ids    = module.vpc.eks_subnet_ids
  db_sub_ids         = module.vpc.db_subnet_ids

}
