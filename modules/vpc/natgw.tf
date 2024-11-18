resource "aws_eip" "this" {
  count = var.enable_nat_gateway ? 1 : 0
  vpc = true
  tags = merge(
    tomap({"Name" = lower(join("-", [var.project, "nat-eip", var.environment]))}),
    local.tags,
  )
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway? 1 : 0
  allocation_id = aws_eip.this[0].id
  subnet_id = local.natgw_subnets[0]

  tags = merge(
    tomap({"Name" = lower(join("-", [var.project, "natgw", var.environment]))}),
    local.tags,
  )
  depends_on = [aws_internet_gateway.this,aws_eip.this]
}

