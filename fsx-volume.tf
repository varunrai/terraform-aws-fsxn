resource "aws_fsx_ontap_volume" "fsxvol" {

  for_each = { for vol in var.volumes : vol.name => vol }

  name                       = vol.value.name
  junction_path              = vol.value.junction_path
  security_style             = vol.value.security_style
  size_in_megabytes          = vol.value.size_in_megabytes
  storage_efficiency_enabled = vol.value.storage_efficiency_enabled
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm[0].id
  skip_final_backup          = vol.value.skip_final_backup

  tiering_policy {
    name           = vol.value.tiering_policy
    cooling_period = (var.value.tiering_policy == "AUTO") ? vol.value.cooling_period : null
  }
}
