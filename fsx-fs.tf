locals {
  filesystem_name = "${var.creator_tag}-${var.filesystem.name}"
}

resource "aws_fsx_ontap_file_system" "fsx_ontap_fs" {
  storage_capacity    = var.filesystem.storage_capacity_in_gb
  throughput_capacity = var.filesystem.throughput_capacity
  deployment_type     = var.filesystem.deployment_type_multiaz ? "MULTI_AZ_1" : "SINGLE_AZ_1"
  subnet_ids          = var.filesystem.subnet_ids
  preferred_subnet_id = var.filesystem.deployment_type_multiaz ? var.filesystem.preferred_subnet_id : var.filesystem.subnet_ids[0]
  fsx_admin_password  = var.fsxn_password
  security_group_ids  = var.filesystem.security_group_ids

  tags = {
    "Name" = local.filesystem_name
  }
}



