
global_settings = {
  default_region = "region1"
  prefix         = null
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  vm_region1 = {
    name = "example-virtual-machine-rg1"
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key                   = "vm_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "example_vm_pip1_rg1"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        #custom_data                     = "scripts/cloud-init/install-rover-tools.config"
        custom_data = "../../examples/compute/virtual_machine/100-single-linux-vm/scripts/cloud-init/install-rover-tools.config"

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                    = "example_vm1-os"
          caching                 = "ReadWrite"
          storage_account_type    = "Standard_LRS"
          disk_encryption_set_key = "set1"
        }
        identity = {
          type = "SystemAssigned"
        }
        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

      }
    }
    data_disks = {
      data1 = {
        name                 = "server1-data1"
        storage_account_type = "Standard_LRS"
        # Only Empty is supported. More community contributions required to cover other scenarios
        create_option           = "Empty"
        disk_size_gb            = "10"
        lun                     = 1
        zones                   = ["1"]
        disk_encryption_set_key = "set1"
      }
    }
  }
}


diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootrg1"
    resource_group_key       = "vm_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}



keyvaults = {
  example_vm_rg1 = {
    name                        = "vmlinuxakv"
    resource_group_key          = "vm_region1"
    sku_name                    = "standard"
    soft_delete_enabled         = true
    purge_protection_enabled    = true
    enabled_for_disk_encryption = true
    tags = {
      env = "Standalone"
    }
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        key_permissions    = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
      }
    }
  }
}

keyvault_keys = {
  key1 = {
    keyvault_key = "example_vm_rg1"
    name         = "disk-key"
    key_type     = "RSA"
    key_size     = "2048"
    key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
  }
}

disk_encryption_sets = {
  set1 = {
    name               = "deskey1"
    resource_group_key = "vm_region1"
    key_vault_key_key  = "key1"
    keyvault = {
      key = "example_vm_rg1"
    }
  }
}
vnets = {
  vnet_region1 = {
    resource_group_key = "vm_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "vm_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}