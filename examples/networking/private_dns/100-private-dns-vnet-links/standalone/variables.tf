variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}


variable "vnets" {
  default = {}
}

variable "private_dns" {
  default = {}
}


variable "tags" {
  default = null
  type    = map(any)
}

variable "logged_aad_app_objectId" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}