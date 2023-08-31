# terraform-aws-fsxn

Terraform Module to deploy basic setup of Amazon FSx for NetApp ONTAP

## How to use the module

Include the module in your terraform code using the example below:

```HCL

module "fsxontap-fs" {
  source = "https://github.com/varunrai/terraform-aws-fsxn.git"

  creator_tag         = "Dummy"
  filesystem_password = var.default_password

  filesystem = {
      name                    = "${var.creator_tag}-FSxN-Demo-1"
      storage_capacity_in_gb  = 1024
      throughput_capacity     = 128
      deployment_type_multiaz = true
      subnet_ids              = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
      preferred_subnet_id     = aws_subnet.public_subnet[0].id
      volume_security_style   = "NTFS"
      security_group_ids      = [aws_security_group.sg-fsx.id]

      svm = [
        {
          enable_smb                 = true
          name                       = "svm01"
          root_volume_security_style = "NTFS"
          svm_admin_password         = var.default_password

          ad = {
              svm_netbiosname          = "FSXN_SVM01"
              domain_name              = "AD.FSXN.COM"
              administrators_group     = "FSXN Administrators"
              ou                       = "OU=FSXN,DC=AD,DC=FSXN,DC=com"
              service_account          = "AD_SERVICE_ACCOUNT"
              service_account_password = "SERVICE_ACCOUNT_PASSWORD"
              dns_ips                  = ["10.1.1.1","10.2.2.2"]
          }

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
}
```
