# Ensure that the Expiration Date is Set for All Keys in Key Vaults Using RBAC

| Provider | Category |
| -------- | -------- |
| Azure    | Data protection |

## Description

This control checks whether Azure Key Vault keys have an explicit, non-empty `expiration_date`. Keys without expiration dates can remain valid indefinitely, increasing the time available to misuse a compromised key.

The policy evaluates `azurerm_key_vault_key` resources in the Terraform plan and requires an expiration date. It does not independently determine whether the vault uses Azure RBAC.

This rule is covered by the [key-expiration-rbac](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/keyvault/key-expiration-rbac.policy.hcl) policy.

## Policy Results

```bash
trace:
	# key-expiration-rbac.policytest.hcl...
	running
	# resource.azurerm_key_vault_key.expiry_set_passes...
	running
	# resource.azurerm_key_vault_key.expiry_set_passes...
	pass
	# resource.azurerm_key_vault_key.expiry_set_other_passes...
	running
	# resource.azurerm_key_vault_key.expiry_set_other_passes...
	pass
	# resource.azurerm_key_vault_key.expiry_absent_fails...
	running
	# resource.azurerm_key_vault_key.expiry_absent_fails...
	pass
	# resource.azurerm_key_vault_key.expiry_null_fails...
	running
	# resource.azurerm_key_vault_key.expiry_null_fails...
	pass
	# resource.azurerm_key_vault_key.expiry_empty_fails...
	running
	# resource.azurerm_key_vault_key.expiry_empty_fails...
	pass
	# key-expiration-rbac.policytest.hcl...
	pass
```

---
