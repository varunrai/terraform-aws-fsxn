resource "aws_fsx_ontap_volume" "fsxvol" {

  for_each = { for vol in var.volumes : vol.name => vol }

  name                       = each.value.name
  junction_path              = each.value.junction_path
  security_style             = each.value.security_style
  size_in_megabytes          = each.value.size_in_megabytes
  storage_efficiency_enabled = each.value.storage_efficiency_enabled
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm.svm01.id
  skip_final_backup          = each.value.skip_final_backup

  tiering_policy {
    name           = each.value.tiering_policy
    cooling_period = (each.value.tiering_policy == "AUTO") ? each.value.cooling_period : null
  }
}
