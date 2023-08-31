locals {
  volumes = flatten([
    for svm_key, svm in var.svm : [
      for volume in svm.volumes : {
        name                       = volume.name
        junction_path              = volume.junction_path
        security_style             = volume.security_style
        size_in_megabytes          = volume.size_in_megabytes
        storage_efficiency_enabled = volume.storage_efficiency_enabled
        svm_name                   = svm_key
        skip_final_backup          = volume.skip_final_backup
        tiering_policy             = volume.tiering_policy
        cooling_period             = volume.cooling_period
      }
    ]
  ])
}

resource "aws_fsx_ontap_volume" "fsxvol" {

  for_each = { for vol in local.volumes : vol.name => vol }

  name                       = each.value.name
  junction_path              = each.value.junction_path
  security_style             = each.value.security_style
  size_in_megabytes          = each.value.size_in_megabytes
  storage_efficiency_enabled = each.value.storage_efficiency_enabled
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm[each.value.svm_name].id
  skip_final_backup          = each.value.skip_final_backup

  tiering_policy {
    name           = each.value.tiering_policy
    cooling_period = (each.value.tiering_policy == "AUTO") ? each.value.cooling_period : null
  }
}
