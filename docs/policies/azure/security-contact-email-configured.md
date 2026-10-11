# Ensure that the Default Defender for Cloud Security Contact Has Valid Email Addresses

| Provider | Category |
| -------- | -------- |
| Azure    | Monitoring |

## Description

This control implements CIS Azure Foundations Benchmark v6.0.0 control 8.1.13.

This control checks whether the default Microsoft Defender for Cloud security contact contains one or more syntactically valid email addresses. Configured security contacts help route notifications to the appropriate security team.

Configure `email` on `azurerm_security_center_contact` from the HashiCorp AzureRM provider. Multiple addresses must be comma-separated; blank entries, malformed addresses, and trailing empty entries fail validation. Only contacts named `default` are checked.

**Enforcement note:** this control checks address syntax, not mailbox ownership, deliverability, or whether notifications are enabled. It evaluates only default contacts declared in the Terraform plan and cannot detect a missing contact. The AzureRM resource does not expose Owner-role selection, minimum alert severity, or attack-path risk thresholds; those controls are not implemented.

Enforcement defaults to `advisory` and can be configured with the `security-contact-email-configured-enforcement-level` input.

This rule is covered by the [security-contact-email-configured](https://github.com/hashicorp/prewritten-terraform-policy-library/blob/main/policies/azure/monitor/security-contact-email-configured.policy.hcl) policy.

## Policy Results

```bash
trace:
	# security-contact-email-configured.policytest.hcl...
	running
	# resource.azurerm_security_center_contact.pass_valid_email...
	running
	# resource.azurerm_security_center_contact.pass_valid_email...
	pass
	# resource.azurerm_security_center_contact.pass_multiple_emails...
	running
	# resource.azurerm_security_center_contact.pass_multiple_emails...
	pass
	# resource.azurerm_security_center_contact.pass_notifications_off...
	running
	# resource.azurerm_security_center_contact.pass_notifications_off...
	pass
	# resource.azurerm_security_center_contact.fail_empty_email...
	running
	# resource.azurerm_security_center_contact.fail_empty_email...
	pass
	# resource.azurerm_security_center_contact.fail_whitespace_email...
	running
	# resource.azurerm_security_center_contact.fail_whitespace_email...
	pass
	# resource.azurerm_security_center_contact.fail_invalid_email...
	running
	# resource.azurerm_security_center_contact.fail_invalid_email...
	pass
	# resource.azurerm_security_center_contact.fail_mixed_valid_and_invalid_emails...
	running
	# resource.azurerm_security_center_contact.fail_mixed_valid_and_invalid_emails...
	pass
	# resource.azurerm_security_center_contact.fail_trailing_empty_email...
	running
	# resource.azurerm_security_center_contact.fail_trailing_empty_email...
	pass
	# resource.azurerm_security_center_contact.pass_non_default_contact_out_of_scope...
	running
	# resource.azurerm_security_center_contact.pass_non_default_contact_out_of_scope...
	pass
	# security-contact-email-configured.policytest.hcl...
	pass
```

---
