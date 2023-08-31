locals {
  filesystem_name = "${var.creator_tag}-${var.fsxn_name}"
}

resource "aws_fsx_ontap_file_system" "fsx_ontap_fs" {
  storage_capacity    = var.fsxn_storage_capacity_in_gb
  throughput_capacity = var.fsxn_throughput_capacity
  deployment_type     = var.deployment_type_multiaz ? "MULTI_AZ_1" : "SINGLE_AZ_1"
  subnet_ids          = var.fsxn_subnet_ids
  preferred_subnet_id = var.deployment_type_multiaz ? var.fsxn_preferred_subnet_id : var.fsxn_subnet_ids[0]
  fsx_admin_password  = var.fsxn_password
  security_group_ids  = var.fsxn_security_group_ids

  tags = {
    "Name" = local.filesystem_name
  }
}



