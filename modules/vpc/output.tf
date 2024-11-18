output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnets" {
  value = local.created_subnets
}

output "test" {
  value = aws_vpc.this.id
}

output "eks_subnet_ids" {
  value       = compact([ for subnet in aws_subnet.this:  length(regexall("^.*eks.*$", subnet.tags.Name)) > 0 ? subnet.id : null ])
  description = "DB Subnet ID"
}

output "eks_subnet_cird" {
  value       = compact([ for subnet in aws_subnet.this:  length(regexall("^.*eks.*$", subnet.tags.Name)) > 0 ? subnet.cidr_block : null ])
  description = "eks Subnet CIRD"
}

output "db_subnet_ids" {
  value       = compact([ for subnet in aws_subnet.this:  length(regexall("^.*db.*$", subnet.tags.Name)) > 0 ? subnet.id : null ])
  description = "db Subnet ID"
}

output "public_subnet_ids" {
  value       = compact([ for subnet in aws_subnet.this:  length(regexall("^.*public.*$", subnet.tags.Name)) > 0 ? subnet.id : null ])
  description = "Public Subnet ID"
}
