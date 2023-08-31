variable "filesystem" {
  type = object({
    name                    = string
    throughput_capacity     = number
    storage_capacity_in_gb  = number
    volume_security_style   = string
    deployment_type_multiaz = bool
    subnet_ids              = list(string)
    preferred_subnet_id     = string
    security_group_ids      = list(string)

    svm = list(object({
      name                       = string
      root_volume_security_style = string
      svm_admin_password         = string
      enable_smb                 = bool

      ad = object({
        dns_ips                  = list(string)
        domain_name              = string
        service_account          = string
        service_account_password = string
        svm_netbiosname          = string
        ou                       = string
        administrators_group     = string
      })

      volumes = list(object({
        name                       = string
        junction_path              = string
        security_style             = string
        size_in_megabytes          = number
        storage_efficiency_enabled = bool
        skip_final_backup          = bool
        tiering_policy             = string
        cooling_period             = number
      }))
    }))
  })
}

variable "filesystem_password" {
  description = "Default Password"
  type        = string
  sensitive   = true
}

variable "creator_tag" {
  description = "Value of the creator tag"
  type        = string
}

variable "enable_smb" {
  description = "Provision SVM with AD Connection"
  type        = bool
  default     = false
}
