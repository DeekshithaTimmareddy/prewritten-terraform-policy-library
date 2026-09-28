# Copyright IBM Corp. 2026

# Ensure that the Expiration Date is Set for All Secrets in Key Vaults Using Access Policies

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "secret-expiration-access-policy-enforcement-level" {
  type    = string
  default = "advisory"
}

locals {
    policy_access_policies = core::getresources("azurerm_key_vault_access_policy", {})
}

resource_policy "azurerm_key_vault_secret" "expiration_date_set_access_policy" {
    locals {
        secret_vault_id = core::try(attrs.key_vault_id, null)

        vault_uses_access_policy = core::length([
            for ap in local.policy_access_policies :
            ap if core::try(ap.key_vault_id, null) == local.secret_vault_id
        ]) > 0

        expiration_date_raw = core::try(attrs.expiration_date, null)
        expiration_date     = local.expiration_date_raw == null ? "" : local.expiration_date_raw

        has_expiration = local.expiration_date != ""
    }

    enforcement_level = input.secret-expiration-access-policy-enforcement-level

    filter = local.vault_uses_access_policy

    enforce {
        condition     = local.has_expiration
        error_message = "Key Vault secret must have an expiration_date set (secrets in access-policy vaults must not be unexpiring)."
    }
}
