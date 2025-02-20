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

variable "public_ip_addresses" {
  default = {}
}

variable "virtual_network_gateways" {
  default = {}
}

variable "local_network_gateways" {
  default = {}
}

variable "virtual_network_gateway_connections" {
  default = {}
}

variable "express_route_circuits" {
  default = {}
}

variable "express_route_circuit_authorizations" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}

