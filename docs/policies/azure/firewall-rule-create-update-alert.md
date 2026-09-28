# Ensure that an Activity Log Alert Exists for Create or Update SQL Server Firewall Rule

| Provider | Category |
| -------- | -------- |
| Azure    | Logging and monitoring |

## Description

This control checks that the Terraform plan includes an enabled Azure Activity Log alert with an action group for the administrative operation `Microsoft.Sql/servers/firewallRules/write`.

The alert must use the `Administrative` category and have at least one configured action group. Without an actionable alert, creation or modification of a SQL Server firewall rule may go undetected. This is a plan-wide existence check and is not tied to an individual SQL Server resource.

This rule is covered by the [firewall-rule-create-update-alert](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/sql/firewall-rule-create-update-alert.policy.hcl) policy.

## Policy Results

```bash
trace:
	# firewall-rule-create-update-alert.policytest.hcl...
	running
	# resource.azurerm_monitor_activity_log_alert.compliant...
	running
	# resource.azurerm_monitor_activity_log_alert.compliant...
	pass
	# resource.azurerm_monitor_activity_log_alert.level_status_caller_present_null_is_compliant...
	running
	# resource.azurerm_monitor_activity_log_alert.level_status_caller_present_null_is_compliant...
	pass
	# resource.azurerm_monitor_activity_log_alert.level_status_caller_set_is_compliant...
	running
	# resource.azurerm_monitor_activity_log_alert.level_status_caller_set_is_compliant...
	pass
	# resource.azurerm_monitor_activity_log_alert.unrelated_but_ok...
	running
	# resource.azurerm_monitor_activity_log_alert.unrelated_but_ok...
	pass
	# firewall-rule-create-update-alert.policytest.hcl...
	pass
```

---
