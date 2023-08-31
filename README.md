# terraform-aws-fsxn

Terraform Module to deploy basic setup of Amazon FSx for NetApp ONTAP

## How to use the module

Include the module in your terraform code using the example below:

```json
module "fsxontap-fs" {
  source = "https://github.com/varunrai/terraform-aws-fsxn.git"

  fsxn_name                    = "${var.creator_tag}-FSxN-Demo-1"
  fsxn_storage_capacity_in_gb  = 1024
  fsxn_throughput_capacity     = 128
  fsxn_password                = var.fsxn_password
  fsxn_deployment_type_multiaz = true
  fsxn_subnet_ids              = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
  fsxn_preferred_subnet_id     = aws_subnet.public_subnet[0].id
  fsxn_volume_security_style   = "NTFS"
  fsxn_security_group_ids      = [aws_security_group.sg-fsx.id]

  creator_tag                 = "Dummy"
  enable_smb                  = true
  ad_domain_name              = "AD.FSXN.COM"
  ad_administrators_group     = "FSXN Administrators"
  ad_ou                       = "OU=FSXN,DC=AD,DC=FSXN,DC=com"
  ad_service_account          = "AD_SERVICE_ACCOUNT"
  ad_service_password         = "SERVICE_ACCOUNT_PASSWORD"
  ad_dns_ips                  = ["10.1.1.1","10.2.2.2"]

  svm = [
    {
      enable_smb                 = true
      name                       = "svm01"
      root_volume_security_style = "NTFS"
      svm_admin_password         = var.default_password
      volumes = [{
        name                       = "vol1"
        junction_path              = "/vol1"
        security_style             = "NTFS"
        size_in_megabytes          = 1024000
        skip_final_backup          = true
        storage_efficiency_enabled = true
        tiering_policy             = "AUTO"
        cooling_period             = 7
        },
        {
          name                       = "vol2"
          junction_path              = "/vol2"
          security_style             = "NTFS"
          size_in_megabytes          = 1024000
          skip_final_backup          = true
          storage_efficiency_enabled = true
          tiering_policy             = "NONE"
          cooling_period             = null
        },
        {
          name                       = "vol3"
          junction_path              = "/vol3"
          security_style             = "NTFS"
          size_in_megabytes          = 1024000
          skip_final_backup          = true
          storage_efficiency_enabled = true
          tiering_policy             = "ALL"
          cooling_period             = null
      }]
    }
  ]
}
```
