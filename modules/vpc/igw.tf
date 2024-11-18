###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
    tags = merge(
    tomap({"Name" = lower(join("-", [var.project, "igw", var.environment]))}),
    local.tags,
  )
  
}

