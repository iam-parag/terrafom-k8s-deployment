variable "region" {}
variable "terraform_state_bucket_bucket_name" {}
variable "environment" {}
variable "owner" {}
variable "management" {}
variable "createdby" {}
variable "project" {}

#VPC
variable "vpc_cidr" {}

#subnets
variable "subnets" {}
variable "enable_nat_gateway" {}
variable "nacl_rules" {}

#eks
variable "eks_kube_version" {}

variable "eks_service_node_group" {
  type = object({
    desired_size   = number
    max_size       = number
    min_size       = number
    ami_type       = string
    capacity_type  = string
    disk_size      = number
    instance_types = list(string)
    labels         = map(any)
  })
}

