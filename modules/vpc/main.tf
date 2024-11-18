resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  # enable_classiclink               = null
  # enable_classiclink_dns_support   = null
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    tomap({ "Name" = lower(join("-", [var.project, "vpc", var.environment])) }),
    local.tags,
  )
}
