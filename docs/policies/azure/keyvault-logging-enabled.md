# Ensure that Logging for Azure Key Vault is Enabled

| Provider | Category |
| -------- | -------- |
| Azure    | Logging and monitoring |

## Description

This control checks that diagnostic settings targeting Azure Key Vault send logs to a configured destination and enable both the `audit` category group (or `AuditEvent` category) and the `allLogs` category group.

Key Vault audit logs provide visibility into access and administrative activity. Without a destination and the required log categories, security investigations and monitoring may lack critical events.

This rule is covered by the [keyvault-logging-enabled](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/keyvault/keyvault-logging-enabled.policy.hcl) policy.

## Policy Results

```bash
trace:
	# keyvault-logging-enabled.policytest.hcl...
	running
	# resource.azurerm_monitor_diagnostic_setting.pass_audit_alllogs_storage...
	running
	# resource.azurerm_monitor_diagnostic_setting.pass_audit_alllogs_storage...
	pass
	# resource.azurerm_monitor_diagnostic_setting.pass_audit_alllogs_law...
	running
	# resource.azurerm_monitor_diagnostic_setting.pass_audit_alllogs_law...
	pass
	# resource.azurerm_monitor_diagnostic_setting.fail_empty_logs...
	running
	# resource.azurerm_monitor_diagnostic_setting.fail_empty_logs...
	pass
	# resource.azurerm_monitor_diagnostic_setting.fail_missing_alllogs...
	running
	# resource.azurerm_monitor_diagnostic_setting.fail_missing_alllogs...
	pass
	# resource.azurerm_monitor_diagnostic_setting.fail_no_destination...
	running
	# resource.azurerm_monitor_diagnostic_setting.fail_no_destination...
	pass
	# keyvault-logging-enabled.policytest.hcl...
	pass
```

---
