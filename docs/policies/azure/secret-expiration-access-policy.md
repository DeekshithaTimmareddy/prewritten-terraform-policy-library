# Ensure that the Expiration Date is Set for All Secrets in Key Vaults Using Access Policies

| Provider | Category |
| -------- | -------- |
| Azure    | Data protection |

## Description

This control checks that secrets in Azure Key Vaults using access policies have an explicit, non-empty `expiration_date`. A secret without an expiration date can remain valid indefinitely, increasing the time available to misuse a compromised secret.

The policy applies to `azurerm_key_vault_secret` resources whose `key_vault_id` matches an `azurerm_key_vault_access_policy` in the Terraform plan. Secrets in vaults with no matching access-policy resource are out of scope for this control.

This rule is covered by the [secret-expiration-access-policy](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/keyvault/secret-expiration-access-policy.policy.hcl) policy.

## Policy Results

```bash
trace:
	# secret-expiration-access-policy.policytest.hcl...
	running
	# resource.azurerm_key_vault_secret.in_scope_with_expiration...
	running
	# resource.azurerm_key_vault_secret.in_scope_with_expiration...
	pass
	# resource.azurerm_key_vault_secret.in_scope_expiration_absent...
	running
	# resource.azurerm_key_vault_secret.in_scope_expiration_absent...
	pass
	# resource.azurerm_key_vault_secret.in_scope_expiration_null...
	running
	# resource.azurerm_key_vault_secret.in_scope_expiration_null...
	pass
	# resource.azurerm_key_vault_secret.in_scope_expiration_empty...
	running
	# resource.azurerm_key_vault_secret.in_scope_expiration_empty...
	pass
	# resource.azurerm_key_vault_secret.out_of_scope_no_access_policy...
	running
	# resource.azurerm_key_vault_secret.out_of_scope_no_access_policy...
	pass
	# secret-expiration-access-policy.policytest.hcl...
	pass
```

---
