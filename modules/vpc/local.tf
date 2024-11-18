locals {
  tags  = {
    Environment = var.environment
    Owner       = var.owner
    Management  = var.management
    CreatedBy   = var.createdby
  }

  subnets = {
    for x in var.subnets :
    "${x.subnet_name}/${x.cidr_block}" => x
  }

  natgw_subnets = compact([ for subnet in aws_subnet.this:  length(regexall("^.*nat.*$", subnet.tags.Name)) > 0 ? subnet.id : null ])

  created_subnets = flatten([
    for key, value in var.subnets : [
      for k, subnet in aws_subnet.this: {
        "subnet_id" = subnet.id, "subnet_name" = value.subnet_name, "subnet_name_tag" = subnet.tags.Name, "type" = value.type, "nacl" = value.nacl
      } if length(regexall("^.*${value.subnet_name}.*$", subnet.tags.Name)) > 0   #v.tags.Name == nacl_name
    ]
  ])

  public_subnets = compact(flatten([
    for key, value in local.created_subnets : value.type == "public" ? value.subnet_id : null
  ]))

  private_subnets = compact(flatten([
    for key, value in local.created_subnets : value.type == "private" ? value.subnet_id : null
  ]))

 

}