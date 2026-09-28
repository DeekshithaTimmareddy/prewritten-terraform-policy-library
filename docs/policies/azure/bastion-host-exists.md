# Ensure an Azure Bastion Host Exists

| Provider | Category |
| -------- | -------- |
| Azure    | Network security |

## Description

This control checks that the Terraform plan contains at least one `azurerm_bastion_host` resource. Azure Bastion provides browser- and portal-based VM connectivity without exposing virtual machines directly to the public internet through RDP or SSH.

The policy evaluates resources declared in the plan; it does not discover Bastion hosts deployed outside the current Terraform plan.

This rule is covered by the [bastion-host-exists](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/network/bastion-host-exists.policy.hcl) policy.

## Policy Results

```bash
trace:
	# bastion-host-exists.policytest.hcl...
	running
	# resource.azurerm_bastion_host.present_standard...
	running
	# resource.azurerm_bastion_host.present_standard...
	pass
	# resource.azurerm_bastion_host.present_second...
	running
	# resource.azurerm_bastion_host.present_second...
	pass
	# resource.azurerm_bastion_host.present_no_public_ip...
	running
	# resource.azurerm_bastion_host.present_no_public_ip...
	pass
	# bastion-host-exists.policytest.hcl...
	pass
```

---
