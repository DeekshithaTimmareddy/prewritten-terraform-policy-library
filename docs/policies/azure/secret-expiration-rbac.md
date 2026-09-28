# Ensure that the Expiration Date is Set for All Secrets in Key Vaults Using RBAC

| Provider | Category |
| -------- | -------- |
| Azure    | Data protection |

## Description

This control checks whether Azure Key Vault secrets have an explicit, non-empty `expiration_date`. Secrets without expiration dates can remain valid indefinitely, increasing the time available to misuse a compromised secret.

The policy evaluates `azurerm_key_vault_secret` resources in the Terraform plan. It rejects missing, null, empty, and whitespace-only values; it does not independently determine whether the vault uses Azure RBAC.

This rule is covered by the [secret-expiration-rbac](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/keyvault/secret-expiration-rbac.policy.hcl) policy.

## Policy Results

```bash
trace:
	# secret-expiration-rbac.policytest.hcl...
	running
	# resource.azurerm_key_vault_secret.pass_future_expiration...
	running
	# resource.azurerm_key_vault_secret.pass_future_expiration...
	pass
	# resource.azurerm_key_vault_secret.pass_past_expiration...
	running
	# resource.azurerm_key_vault_secret.pass_past_expiration...
	pass
	# resource.azurerm_key_vault_secret.fail_expiration_absent...
	running
	# resource.azurerm_key_vault_secret.fail_expiration_absent...
	pass
	# resource.azurerm_key_vault_secret.fail_expiration_null...
	running
	# resource.azurerm_key_vault_secret.fail_expiration_null...
	pass
	# resource.azurerm_key_vault_secret.fail_expiration_empty...
	running
	# resource.azurerm_key_vault_secret.fail_expiration_empty...
	pass
	# resource.azurerm_key_vault_secret.fail_expiration_whitespace_only...
	running
	# resource.azurerm_key_vault_secret.fail_expiration_whitespace_only...
	pass
	# secret-expiration-rbac.policytest.hcl...
	pass
```

---
