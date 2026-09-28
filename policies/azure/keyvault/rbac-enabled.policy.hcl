# Copyright IBM Corp. 2026

# Ensure Azure Key Vault Uses the Azure RBAC Permission Model

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "rbac-enabled-enforcement-level" {
  type    = string
  default = "advisory"
}

resource_policy "azurerm_key_vault" "rbac_authorization_enabled" {
    enforcement_level = input.rbac-enabled-enforcement-level

    locals {
        rbac_new_raw    = core::try(attrs.rbac_authorization_enabled, null)
        rbac_legacy_raw = core::try(attrs.enable_rbac_authorization, null)
        rbac_enabled    = local.rbac_new_raw == true || local.rbac_legacy_raw == true
    }

    enforce {
        condition     = local.rbac_enabled
        error_message = "Key Vault must use the Azure RBAC permission model (rbac_authorization_enabled, or enable_rbac_authorization on provider <5.0.0, must be set to true)."
    }
}
