# Copyright IBM Corp. 2026

# Ensure that the Expiration Date is Set for All Keys in Key Vaults Using Access Policies

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "key-expiration-access-policy-enforcement-level" {
  type    = string
  default = "advisory"
}

resource_policy "azurerm_key_vault_key" "8_3_2" {
  enforcement_level = input.key-expiration-access-policy-enforcement-level

  locals {
    expiration_raw = core::try(attrs.expiration_date, null)
    expiration     = local.expiration_raw == null ? "" : local.expiration_raw
    has_expiration = local.expiration != ""
  }

  enforce {
    condition     = local.has_expiration
    error_message = "Key Vault key must have an expiration date set (expiration_date); by default keys never expire."
  }
}
