
variable "environment" {}
variable "owner" {}
variable "management" {}
variable "createdby" {}
variable "project" {}


variable "eks_kube_version" {
  type = string
}

variable "public_sub_ids" {
  type = list(string)
}

variable "private_sub_ids" {
  type = list(string)
}

variable "db_sub_ids" {
  type = list(string)
}
variable "key_name_eks" {
   type = string
}

variable "service_node_group" {
  type = object({  
    desired_size   =  number
    max_size       =  number
    min_size       =  number     
    ami_type       =  string
    capacity_type  =  string
    disk_size      =  number
    instance_types =  list(string)
    labels         =  map(any)
  })
}



