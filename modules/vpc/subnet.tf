resource "aws_subnet" "this" {
  for_each                        = local.subnets
  vpc_id                          = aws_vpc.this.id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.az
  
  tags = merge(
    tomap({"Name" =  lower(join("-", [var.project, each.value.subnet_name, var.environment]))}),
    local.tags
  )
}
