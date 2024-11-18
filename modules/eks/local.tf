locals {
  pub_pri_subnet_ids_list       = concat(var.public_sub_ids, var.private_sub_ids , var.db_sub_ids)
}
