# module "lb_sg" {
#   source = "./modules/security-groups"

#   name        = "lb-sg2"
#   description = "Security group for loadbalancer"
#   vpc_id      = module.vpc.vpc_id

#   ingress_cidr_blocks = concat(["0.0.0.0/0"])
#   ingress_rules       = ["https-443-tcp", "http-80-tcp"]

#   computed_egress_with_source_security_group_id = [
#     # {
#     #   rule                     = "app-8080-tcp"
#     #   source_security_group_id = module.eks_sg.security_group_id
#     # },
#     {
#       rule                     = "app-8443-tcp"
#       source_security_group_id = module.eks_sg.security_group_id
#     },
#     {
#       rule                     = "app-9191-tcp"
#       source_security_group_id = module.eks_sg.security_group_id
#     }
#   ]
#   tags = merge(
#     tomap({ "Name" = lower(join("-", [var.project, "lb-sg2", var.environment])) }),
#     local.tags,
#   )
# }

# module "eks_sg" {
#   source = "./modules/security-groups"

#   name        = "eks-sg2"
#   description = "Security group for eks Cluster"
#   vpc_id      = module.vpc.vpc_id

#   #add_efs_rules = "true"

#   ingress_cidr_blocks = module.vpc.eks_subnet_cird
#   #ingress_rules       = ["app-2049-tcp"]

#   computed_ingress_with_source_security_group_id = [
#     {
#       rule                     = "app-8080-tcp"
#       source_security_group_id = module.lb_sg.security_group_id
#     },
#     {
#       rule                     = "app-8443-tcp"
#       source_security_group_id = module.lb_sg.security_group_id
#     },
#     {
#       rule                     = "app-9090-tcp"
#       source_security_group_id = module.lb_sg.security_group_id
#     },
#     {
#      rule                     = "app-9191-tcp"
#      source_security_group_id = module.lb_sg.security_group_id
#     },
#   ]

# number_of_computed_ingress_with_cidr_blocks = 1
#   computed_ingress_with_cidr_blocks = [
#     {
#       rule = "app-2049-tcp"
#       #cidr_blocks = module.vpc.eks_subnet_cird[0]
#     }
#   ]


# egress_cidr_blocks = module.vpc.eks_subnet_cird
# number_of_computed_egress_with_cidr_blocks = 2
# computed_egress_with_cidr_blocks = [
#   {
#     rule = "app-2049-tcp"
#   },
#   {
#     rule = "https-443-tcp"
#     cidr_blocks = "0.0.0.0/0"
#   }
# ]

#   computed_egress_with_source_security_group_id = [
#     {
#       rule                     = "mysql-aurora"
#       source_security_group_id = module.db_sg.security_group_id
#     },
#     {
#      rule                     = "app-9191-tcp"
#      source_security_group_id = module.lb_sg.security_group_id
#     },
#   ]

# #  efs_subnet_egress_cidr_blocks = module.vpc.eks_subnet_cird
# #  egress_rules       = ["https-443-tcp"]


#   tags = merge(
#     tomap({ "Name" = lower(join("-", [var.project, "eks-sg2", var.environment])) }),
#     local.tags,
#   )
# }

# module "db_sg" {
#   source = "./modules/security-groups"

#   name        = "db-sg2"
#   description = "Security group for db"
#   vpc_id      = module.vpc.vpc_id

#   computed_ingress_with_source_security_group_id = [{
#       rule                     = "mysql-aurora"
#       source_security_group_id = module.eks_sg.security_group_id
#     }
#   ]
#   tags = merge(
#     tomap({ "Name" = lower(join("-", [var.project, "db-sg2", var.environment])) }),
#     local.tags,
#   )

# }
