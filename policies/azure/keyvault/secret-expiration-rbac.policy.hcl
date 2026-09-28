# Copyright IBM Corp. 2026

# Ensure that the Expiration Date is Set for All Secrets in Key Vaults Using RBAC

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "secret-expiration-rbac-enforcement-level" {
  type    = string
  default = "advisory"
}

resource_policy "azurerm_key_vault_secret" "expiration_date_set_rbac" {
  enforcement_level = input.secret-expiration-rbac-enforcement-level

  enforce {
    condition     = core::try(attrs.expiration_date, null) != null && core::try(core::regex("\\S", core::try(attrs.expiration_date, "")), null) != null
    error_message = "Key Vault secret must have an expiration date set (expiration_date must be a non-empty, non-whitespace value)."
  }
}
