# Ensure that the Expiration Date is Set for All Keys in Key Vaults Using Access Policies

| Provider | Category |
| -------- | -------- |
| Azure    | Data protection |

## Description

This control checks whether Azure Key Vault keys have an explicit, non-empty `expiration_date`. Keys without expiration dates can remain valid indefinitely, increasing the time available to misuse a compromised key.

The policy evaluates `azurerm_key_vault_key` resources in the Terraform plan. It requires an expiration date to be specified; it does not independently determine the vault's permission model.

This rule is covered by the [key-expiration-access-policy](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/keyvault/key-expiration-access-policy.policy.hcl) policy.

## Policy Results

```bash
trace:
	# key-expiration-access-policy.policytest.hcl...
	running
	# resource.azurerm_key_vault_key.expiration_set...
	running
	# resource.azurerm_key_vault_key.expiration_set...
	pass
	# resource.azurerm_key_vault_key.expiration_absent...
	running
	# resource.azurerm_key_vault_key.expiration_absent...
	pass
	# resource.azurerm_key_vault_key.expiration_null...
	running
	# resource.azurerm_key_vault_key.expiration_null...
	pass
	# resource.azurerm_key_vault_key.expiration_empty...
	running
	# resource.azurerm_key_vault_key.expiration_empty...
	pass
	# resource.azurerm_key_vault_key.rsa_expiration_set...
	running
	# resource.azurerm_key_vault_key.rsa_expiration_set...
	pass
	# key-expiration-access-policy.policytest.hcl...
	pass
```

---
