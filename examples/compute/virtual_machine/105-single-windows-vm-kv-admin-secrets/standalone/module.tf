module "caf" {
  source = "../../../../../"

  global_settings          = var.global_settings
  tags                     = var.tags
  resource_groups          = var.resource_groups
  storage_accounts         = var.storage_accounts
  keyvaults                = var.keyvaults
  managed_identities       = var.managed_identities
  role_mapping             = var.role_mapping
  keyvault_access_policies = var.keyvault_access_policies

  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_log_analytics    = var.diagnostic_log_analytics
    diagnostic_storage_accounts = var.diagnostic_storage_accounts
  }

  compute = {
    virtual_machines = var.virtual_machines
  }

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    public_ip_addresses               = var.public_ip_addresses
  }

  security = {
    dynamic_keyvault_secrets = var.dynamic_keyvault_secrets
    keyvault_keys            = var.keyvault_keys
    disk_encryption_sets     = var.disk_encryption_sets
  }
}

output "diagnostics" {
  value = module.caf.diagnostics
}
