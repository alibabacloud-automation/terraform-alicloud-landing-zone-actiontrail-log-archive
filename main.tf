locals {
  actiontrail_log_archive_enabled       = anytrue([var.delivery_to_sls, var.delivery_to_oss])
  default_sls_project_name              = "terraform-actiontrail-log-archive-${random_integer.default.result}"
  default_bucket_name                   = "terraform-actiontrail-log-archive-${random_integer.default.result}"
  sls_project_name_for_actiontrail      = var.delivery_to_sls ? coalesce(var.sls_project_name_for_actiontrail, local.default_sls_project_name) : null
  actiontrail_sls_project_arn           = var.delivery_to_sls ? format("acs:log:%s:%s:project/%s", data.alicloud_regions.sls_project_region.regions[0].id, data.alicloud_account.logarchive.id, alicloud_log_project.actiontrail[0].project_name) : null
  oss_bucket_name_for_actiontrail       = var.delivery_to_oss ? coalesce(var.oss_bucket_name_for_actiontrail, local.default_bucket_name) : null
  cross_account_delivery                = data.alicloud_account.management.id != data.alicloud_account.logarchive.id
  actiontrail_log_archive_role_document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "%s@actiontrail.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# Retrieve accounts information
data "alicloud_account" "management" {
  provider = alicloud.management_account
}

data "alicloud_account" "logarchive" {
  provider = alicloud.log_archive_account
}

data "alicloud_regions" "sls_project_region" {
  provider = alicloud.log_archive_account

  current = true
}

# Activate oss and sls service in log archive account if needed
data "alicloud_oss_service" "enable_oss_service" {
  count    = var.delivery_to_oss ? 1 : 0
  provider = alicloud.log_archive_account

  enable = "On"
}

data "alicloud_log_service" "enable_sls_service" {
  count    = var.delivery_to_sls ? 1 : 0
  provider = alicloud.log_archive_account

  enable = "On"
}

# Create log project or oss bucket in log archive account
resource "alicloud_log_project" "actiontrail" {
  count    = var.delivery_to_sls ? 1 : 0
  provider = alicloud.log_archive_account

  project_name = local.sls_project_name_for_actiontrail
  description  = var.sls_project_description
  tags         = var.sls_project_tags
}

resource "alicloud_oss_bucket" "actiontrail" {
  count    = var.delivery_to_oss ? 1 : 0
  provider = alicloud.log_archive_account

  bucket = local.oss_bucket_name_for_actiontrail

  server_side_encryption_rule {
    sse_algorithm = "AES256"
  }

  tags = var.oss_bucket_tags
}

resource "alicloud_oss_bucket_acl" "actiontrail" {
  count    = var.delivery_to_oss ? 1 : 0
  provider = alicloud.log_archive_account

  bucket = alicloud_oss_bucket.actiontrail[0].id
  acl    = "private"
}



resource "alicloud_ram_role" "actiontrail" {
  count    = alltrue([local.actiontrail_log_archive_enabled, local.cross_account_delivery]) ? 1 : 0
  provider = alicloud.log_archive_account

  name        = "ActionTrailLogArchiveRole"
  document    = format(local.actiontrail_log_archive_role_document, data.alicloud_account.management.id)
  description = "Created by terraform-alicloud-landing-zone-actiontrail-log-archive module."
}

resource "alicloud_ram_role_policy_attachment" "attach_policy" {
  count    = alicloud_ram_role.actiontrail != null && length(alicloud_ram_role.actiontrail) > 0 ? 1 : 0
  provider = alicloud.log_archive_account

  policy_name = "AliyunActionTrailDeliveryPolicy"
  policy_type = "System"
  role_name   = alicloud_ram_role.actiontrail[0].id
}

# Create ActionTrail trail
resource "alicloud_actiontrail_trail" "trail" {
  count = local.actiontrail_log_archive_enabled ? 1 : 0

  trail_name            = var.actiontrail_trail_name
  event_rw              = var.actiontrail_trail_event_rw
  oss_bucket_name       = local.oss_bucket_name_for_actiontrail
  sls_project_arn       = local.actiontrail_sls_project_arn
  oss_write_role_arn    = local.cross_account_delivery ? alicloud_ram_role.actiontrail[0].arn : null
  sls_write_role_arn    = local.cross_account_delivery ? alicloud_ram_role.actiontrail[0].arn : null
  is_organization_trail = true

  provider = alicloud.management_account

  depends_on = [alicloud_ram_role_policy_attachment.attach_policy]
}
