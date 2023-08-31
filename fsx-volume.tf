resource "aws_fsx_ontap_volume" "fsxvol" {

  for_each = { for vol in var.volumes : vol.name => vol }

  name                       = vol.value.name
  junction_path              = vol.value.junction_path
  security_style             = vol.value.security_style
  size_in_megabytes          = vol.value.size_in_megabytes
  storage_efficiency_enabled = vol.value.storage_efficiency_enabled
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm01.id
  skip_final_backup          = vol.value.skip_final_backup

  tiering_policy {
    name           = vol.value.tiering_policy
    cooling_period = (var.value.tiering_policy == "AUTO") ? vol.value.cooling_period : null
  }
}

/* resource "aws_fsx_ontap_volume" "fsxvol01" {
  name                       = "vol1"
  junction_path              = "/vol1"
  security_style             = "NTFS"
  size_in_megabytes          = 1280000
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm01.id
  skip_final_backup          = true

  tiering_policy {
    name           = "AUTO"
    cooling_period = 2
  }
}

resource "aws_fsx_ontap_volume" "fsxvol02" {
  name                       = "vol2"
  junction_path              = "/vol2"
  security_style             = var.fsxn_volume_security_style
  size_in_megabytes          = 2560000
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm01.id
  skip_final_backup          = true

  tiering_policy {
    name           = "AUTO"
    cooling_period = 30
  }
}

resource "aws_fsx_ontap_volume" "fsxvol03" {
  name                       = "vol3"
  junction_path              = "/vol3"
  security_style             = var.fsxn_volume_security_style
  size_in_megabytes          = 2560000
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm01.id
  skip_final_backup          = true

  tiering_policy {
    name = "ALL"
  }
} */
