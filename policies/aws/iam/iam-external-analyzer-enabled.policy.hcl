# Copyright IBM Corp. 2026

# IAM Access Analyzer external access analyzer should be enabled

policy {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0, < 7.0.0"
    }
  }
}

input "iam-external-analyzer-enabled-enforcement-level" {
  type    = string
  default = "advisory"
}

resource_policy "aws_accessanalyzer_analyzer" "external_analyzer_enabled" {
  enforcement_level = input.iam-external-analyzer-enabled-enforcement-level

  locals {
    analyzer_type = core::try(attrs.type, "ACCOUNT")
    is_compliant  = local.analyzer_type == "ACCOUNT"
  }

  enforce {
    condition = local.is_compliant
    error_message = "IAM Access Analyzer must be enabled as an external access analyzer with type = 'ACCOUNT'. Types 'ACCOUNT_UNUSED_ACCESS', 'ORGANIZATION', and 'ORGANIZATION_UNUSED_ACCESS' do not satisfy IAM.28, which requires an external access analyzer scoped to the AWS account."
  }
}
