output "fsx_ontap" {
  description = "FSxN Object"
  value       = aws_fsx_ontap_file_system.fsx_ontap_fs
}

output "fsx_management_management_ip" {
  description = "FSxN Management IP"
  value       = aws_fsx_ontap_file_system.fsx_ontap_fs.endpoints[0].management[0].ip_addresses
}

output "fsx_svm" {
  description = "FSxN SVMs"
  value       = aws_fsx_ontap_storage_virtual_machine.fsxsvm
}

output "fsx_volumes" {
  description = "FSxN Volumes"
  value       = aws_fsx_ontap_volume.fsxvol
}
