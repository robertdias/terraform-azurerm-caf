variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "role_mapping" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "aks_clusters" {
  default = {}
}

variable "azure_container_registries" {
  default = {}
}

variable "diagnostic_log_analytics" {
  default = {}
}

variable "virtual_machines" {
  default = {}
}

variable "network_security_group_definition" {
  default = {}
}

variable "vnets" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}
