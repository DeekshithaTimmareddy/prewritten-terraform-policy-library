# Copyright IBM Corp. 2026

# Ensure an Azure Bastion Host Exists

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "bastion-host-exists-enforcement-level" {
  type    = string
  default = "advisory"
}

locals {
  all_bastion_hosts = core::getresources("azurerm_bastion_host", {})
  bastion_count     = core::length(local.all_bastion_hosts)
}

resource_policy "azurerm_bastion_host" "ensure_bastion_host_exists" {
  enforcement_level = input.bastion-host-exists-enforcement-level

  enforce {
    condition     = local.bastion_count > 0
    error_message = "An Azure Bastion Host must exist: at least one azurerm_bastion_host is required for secure VM remote access."
  }
}
