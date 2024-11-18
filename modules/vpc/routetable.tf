#######################################################################
# Publiс routes
#######################################################################
resource "aws_route_table" "public" {
  count = length(local.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id
  tags = merge(
    tomap({"Name" = lower(join("-", [var.project, "public-rt", var.environment]))}),
    local.tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count = length(local.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count = length(local.public_subnets) > 0 ? length(local.public_subnets) : 0
  subnet_id      = local.public_subnets[count.index]
  route_table_id = aws_route_table.public[0].id
}


#######################################################################
# Private routes
# There are as many routing tables as the number of NAT gateways
#######################################################################

resource "aws_route_table" "private" {
  count = length(local.private_subnets) > 0 ? 1 : 0
  
  vpc_id = aws_vpc.this.id
  tags = merge(
    tomap({"Name" = lower(join("-", [var.project, "private-rt", var.environment]))}),
    local.tags,
  )
}

resource "aws_route" "private_nat_gateway" {
  count = var.enable_nat_gateway && length(local.private_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count = length(local.private_subnets) > 0 ? length(local.private_subnets) : 0
  subnet_id      = local.private_subnets[count.index]
  route_table_id = aws_route_table.private[0].id
}