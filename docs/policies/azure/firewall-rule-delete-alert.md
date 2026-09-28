# Ensure that an Activity Log Alert Exists for Delete SQL Server Firewall Rule

| Provider | Category |
| -------- | -------- |
| Azure    | Logging and monitoring |

## Description

This control checks that the Terraform plan includes an enabled Azure Activity Log alert with an action group for the administrative operation `Microsoft.Sql/servers/firewallRules/delete`.

The alert must use the `Administrative` category and have at least one configured action group. This ensures that deletion of a SQL Server firewall rule can trigger a notification or response. The policy checks for an alert anywhere in the Terraform plan rather than associating it with one SQL Server.

This rule is covered by the [firewall-rule-delete-alert](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/sql/firewall-rule-delete-alert.policy.hcl) policy.

## Policy Results

```bash
trace:
	# firewall-rule-delete-alert.policytest.hcl...
	running
	# resource.azurerm_monitor_activity_log_alert.compliant_delete_fw_rule...
	running
	# resource.azurerm_monitor_activity_log_alert.compliant_delete_fw_rule...
	pass
	# resource.azurerm_monitor_activity_log_alert.compliant_matches_official_remediation...
	running
	# resource.azurerm_monitor_activity_log_alert.compliant_matches_official_remediation...
	pass
	# resource.azurerm_monitor_activity_log_alert.unrelated_but_ok...
	running
	# resource.azurerm_monitor_activity_log_alert.unrelated_but_ok...
	pass
	# firewall-rule-delete-alert.policytest.hcl...
	pass
```

---
