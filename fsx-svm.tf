resource "aws_fsx_ontap_storage_virtual_machine" "fsxsvm" {

  for_each = { for svm in var.filesystem.svm : svm.name => svm }

  file_system_id             = aws_fsx_ontap_file_system.fsx_ontap_fs.id
  name                       = each.value.name
  root_volume_security_style = each.value.enable_smb ? "NTFS" : each.value.root_volume_security_style
  svm_admin_password         = each.value.svm_admin_password

  lifecycle {
    ignore_changes = [active_directory_configuration]
  }

  dynamic "active_directory_configuration" {
    for_each = each.value.enable_smb ? [1] : []
    content {
      netbios_name = each.value.ad.svm_netbiosname
      self_managed_active_directory_configuration {
        domain_name                            = each.value.ad.domain_name
        dns_ips                                = each.value.ad.dns_ips
        file_system_administrators_group       = each.value.ad.administrators_group
        organizational_unit_distinguished_name = each.value.ad.ou
        username                               = each.value.ad.service_account
        password                               = each.value.ad.service_Account_password
      }
    }
  }
}
