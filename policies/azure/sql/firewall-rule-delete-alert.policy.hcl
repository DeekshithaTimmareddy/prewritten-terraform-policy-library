# Copyright IBM Corp. 2026

# Ensure that an Activity Log Alert Exists for Delete SQL Server Firewall Rule

policy {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

input "firewall-rule-delete-alert-enforcement-level" {
  type    = string
  default = "advisory"
}

locals {
  delete_fw_rule_alerts = core::getresources("azurerm_monitor_activity_log_alert", {})

  delete_fw_rule_qualifying_alerts = [
    for alert in local.delete_fw_rule_alerts : alert
    if core::try(alert.enabled, true) == true
    && core::try(core::length([for a in core::try([for x in alert.action : x], []) : a if core::try(a.action_group_id, "") != ""]), 0) > 0
    && core::try(core::length([
      for c in core::try([for cr in alert.criteria : cr], []) : c
      if core::try(c.category, "") == "Administrative"
      && core::try(c.operation_name, "") == "Microsoft.Sql/servers/firewallRules/delete"
    ]), 0) > 0
  ]

  delete_fw_rule_has_qualifying_alert = core::try(core::length(local.delete_fw_rule_qualifying_alerts), 0) > 0
}

resource_policy "*" "activity_log_alert_delete_sql_firewall_rule" {
  enforcement_level = input.firewall-rule-delete-alert-enforcement-level

  enforce {
    condition     = local.delete_fw_rule_has_qualifying_alert
    error_message = "An enabled activity log alert with an assigned action group must exist for category='Administrative' and operation_name='Microsoft.Sql/servers/firewallRules/delete' (Delete SQL Server Firewall Rule)."
  }
}
