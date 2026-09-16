# Copyright IBM Corp. 2026

policytest {
  targets = ["iam-external-analyzer-enabled.policy.hcl"]
}

# PASS: Analyzer explicitly configured with type ACCOUNT satisfies the requirement.
resource "aws_accessanalyzer_analyzer" "pass_type_account" {
  attrs = {
    analyzer_name = "my-account-analyzer"
    type          = "ACCOUNT"
  }
}

# PASS: Analyzer with type omitted defaults to ACCOUNT via core::try.
resource "aws_accessanalyzer_analyzer" "pass_type_omitted" {
  attrs = {
    analyzer_name = "my-default-analyzer"
  }
}

# FAIL: Analyzer scoped to the entire organization is non-compliant.
resource "aws_accessanalyzer_analyzer" "fail_type_organization" {
  expect_failure = true
  attrs = {
    analyzer_name = "my-org-analyzer"
    type          = "ORGANIZATION"
  }
}

# FAIL: Analyzer scoped to an organization unused access type is non-compliant.
resource "aws_accessanalyzer_analyzer" "fail_type_organization_unused_access" {
  expect_failure = true
  attrs = {
    analyzer_name = "my-org-unused-analyzer"
    type          = "ORGANIZATION_UNUSED_ACCESS"
  }
}

# FAIL: Analyzer with account unused access type is non-compliant.
resource "aws_accessanalyzer_analyzer" "fail_type_account_unused_access" {
  expect_failure = true
  attrs = {
    analyzer_name = "my-account-unused-analyzer"
    type          = "ACCOUNT_UNUSED_ACCESS"
  }
}
