policytest {
  targets = ["2-10-network-change-alert.policy.hcl", "2-12-sql-config-change-alert.policy.hcl"]
}

resource "google_logging_metric" "network_changes" {
  attrs = {
    name   = "coexisting-network"
    filter = "resource.type=\"gce_network\" AND (protoPayload.methodName:\"compute.networks.insert\" OR protoPayload.methodName:\"compute.networks.patch\" OR protoPayload.methodName:\"compute.networks.delete\" OR protoPayload.methodName:\"compute.networks.removePeering\" OR protoPayload.methodName:\"compute.networks.addPeering\")"
  }
}

resource "google_logging_metric" "sql_changes" {
  attrs = {
    name   = "coexisting-sql"
    filter = "protoPayload.methodName=\"cloudsql.instances.update\""
  }
}

resource "google_monitoring_alert_policy" "network_alert" {
  attrs = {
    enabled               = true
    notification_channels = ["projects/my-project/notificationChannels/1234567890"]
    conditions = [{ condition_threshold = [{
      filter = "metric.type=\"logging.googleapis.com/user/coexisting-network\" AND resource.type=\"global\""
    }] }]
  }
}

resource "google_monitoring_alert_policy" "sql_alert" {
  attrs = {
    enabled               = true
    notification_channels = ["projects/my-project/notificationChannels/1234567890"]
    conditions = [{ condition_threshold = [{
      filter = "metric.type=\"logging.googleapis.com/user/coexisting-sql\" AND resource.type=\"global\""
    }] }]
  }
}

resource "google_logging_metric" "unrelated_metric" {
  attrs = {
    name   = "unrelated-compute"
    filter = "resource.type=\"gce_instance\" AND severity>=ERROR"
  }
}

resource "google_monitoring_alert_policy" "unrelated_disabled_alert" {
  attrs = {
    enabled = false
    conditions = [{ condition_threshold = [{
      filter = "metric.type=\"logging.googleapis.com/user/unrelated-compute\" AND resource.type=\"global\""
    }] }]
  }
}