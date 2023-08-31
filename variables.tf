variable "fsxn_name" {
  description = "File System Name"
  type        = string
  default     = "FSxN-Demo-1"
}

variable "fsxn_password" {
  description = "Default Password"
  type        = string
  sensitive   = true
}

variable "fsxn_svm_name" {
  description = "Default SVM Name"
  type        = string
  default     = "svm01"
}

variable "fsxn_throughput_capacity" {
  description = "Default Throughput Capacity"
  type        = number
  default     = 128
}

variable "fsxn_storage_capacity_in_gb" {
  description = "Storage Capacity in GB"
  type        = number
  default     = 1024
}

variable "fsxn_volume_security_style" {
  description = "Default Volume Security Style"
  type        = string
  default     = "NTFS"
}

variable "fsxn_subnet_ids" {
  description = "FSxN Deployment Subnet IDs - Specify Two when using MAZ or One when using SAZ"
  type        = list(string)
}

variable "fsxn_preferred_subnet_id" {
  description = "FSxN Deployment Preferred Subnet ID"
  type        = string
}

variable "fsxn_deployment_type" {
  description = "FSxN Deployment Type - Multi AZ (set as true) or Single AZ (set as false)"
  type        = bool
  default     = false
}

variable "fsxn_security_group_ids" {
  description = "FSxN Security Groups IDs"
  type        = list(string)
}

variable "creator_tag" {
  description = "Value of the creator tag"
  type        = string
}

variable "deployment_type_multiaz" {
  description = "Provision an Multi-AZ FSxN instance"
  type        = bool
  default     = false
}

variable "enable_smb" {
  description = "Provision SVM with AD Connection"
  type        = bool
  default     = false
}

variable "ad_dns_ips" {
  description = "AD - DNS IPs"
  type        = list(string)
  default     = []
}

variable "ad_domain_name" {
  description = "AD - Domain Name"
  type        = string
  default     = "ad.fsxn.com"
}

variable "ad_service_account" {
  description = "AD - Service Account"
  type        = string
  default     = "fsxnadmin"
}

variable "ad_service_password" {
  description = "AD - Service Account Password"
  type        = string
  sensitive   = true
}

variable "ad_svm_netbiosname" {
  description = "AD - SVM Netbios Name"
  type        = string
  default     = "FSXN-SVM01"
}

variable "ad_ou" {
  description = "AD - OU"
  type        = string
  default     = "OU=FSXN,DC=ad,DC=FSXN,DC=com"
}

variable "ad_administrators_group" {
  description = "AD - Adminitrators Group"
  type        = string
  default     = "FSXN Administrators"
}

variable "svm" {
  type = list(object({
    name                       = string
    root_volume_security_style = string
    svm_admin_password         = string
    enable_smb                 = bool
  }))

  default = list(object({
    root_volume_security_style = "NTFS"
    svm_admin_password         = ""
    enable_smb                 = false
  }))
}

variable "volumes" {
  type = list(object({
    name                       = string
    junction_path              = string
    security_style             = string
    size_in_megabytes          = number
    storage_efficiency_enabled = bool
    storage_virtual_machine_id = string
    skip_final_backup          = bool
    tiering_policy             = string
  }))

  default = list(object({
    security_style              = "NTFS"
    storage_efficiency_enabled  = true
    skip_final_backup           = true
    tiering_policy              = "AUTO"
    tiering_policy_cooling_days = "7"
  }))
}
