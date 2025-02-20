variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "vnets" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "proximity_placement_groups" {
  default = {}
}

variable "virtual_machines" {
  default = {}
}

variable "keyvaults" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}