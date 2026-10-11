# Ensure that DDoS Network Protection is Enabled on Virtual Networks

| Provider | Category |
| -------- | -------- |
| Azure    | Network security |

## Description

This control implements CIS Azure Foundations Benchmark v6.0.0 control 8.5.

This control checks whether Azure Virtual Networks enable DDoS Network Protection and reference a DDoS protection plan. Network-level DDoS protection helps mitigate attacks that attempt to exhaust application connectivity or availability.

Each virtual network must declare a `ddos_protection_plan` block with `enable = true` and a nonblank `id`. Missing blocks, disabled protection, and empty plan references do not meet the requirement.

**Enforcement note:** a plan reference does not independently verify the referenced plan's live state. Deploying a DDoS protection plan can incur substantial charges; speculative policy testing does not require applying one.

Enforcement defaults to `advisory` and can be configured with the `vnet-ddos-protection-enabled-enforcement-level` input.

This rule is covered by the [vnet-ddos-protection-enabled](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/network/vnet-ddos-protection-enabled.policy.hcl) policy.

## Policy Results

```bash
trace:
	# vnet-ddos-protection-enabled.policytest.hcl...
	running
	# resource.azurerm_virtual_network.pass_ddos_enabled...
	running
	# resource.azurerm_virtual_network.pass_ddos_enabled...
	pass
	# resource.azurerm_virtual_network.fail_ddos_disabled...
	running
	# resource.azurerm_virtual_network.fail_ddos_disabled...
	pass
	# resource.azurerm_virtual_network.fail_ddos_plan_block_absent...
	running
	# resource.azurerm_virtual_network.fail_ddos_plan_block_absent...
	pass
	# resource.azurerm_virtual_network.fail_ddos_plan_block_empty...
	running
	# resource.azurerm_virtual_network.fail_ddos_plan_block_empty...
	pass
	# resource.azurerm_virtual_network.fail_enable_null...
	running
	# resource.azurerm_virtual_network.fail_enable_null...
	pass
	# resource.azurerm_virtual_network.fail_plan_id_null...
	running
	# resource.azurerm_virtual_network.fail_plan_id_null...
	pass
	# resource.azurerm_virtual_network.fail_plan_id_empty...
	running
	# resource.azurerm_virtual_network.fail_plan_id_empty...
	pass
	# resource.azurerm_virtual_network.pass_other_vnet_independent...
	running
	# resource.azurerm_virtual_network.pass_other_vnet_independent...
	pass
	# vnet-ddos-protection-enabled.policytest.hcl...
	pass
```

---
