# Copyright IBM Corp. 2026

# Ensure that the Expiration Date is Set for All Keys in Key Vaults Using RBAC

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "key-expiration-rbac-enforcement-level" {
  type    = string
  default = "advisory"
}

resource_policy "azurerm_key_vault_key" "expiration_date_set" {
  enforcement_level = input.key-expiration-rbac-enforcement-level

  locals {
    expiration_raw = core::try(attrs.expiration_date, null)
    has_expiration = local.expiration_raw != null && local.expiration_raw != ""
  }

  enforce {
    condition     = local.has_expiration
    error_message = "Key Vault key must have an expiration_date set (keys never expire by default; set an explicit expiration to enforce rotation)."
  }
}
