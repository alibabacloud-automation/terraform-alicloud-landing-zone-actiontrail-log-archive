provider "alicloud" {
  alias  = "management_account"
  region = "cn-shanghai"
}

provider "alicloud" {
  alias  = "log_archive_account"
  region = "cn-shanghai"
}

module "log_archive" {
  source = "../../"

  providers = {
    alicloud.management_account  = alicloud.management_account
    alicloud.log_archive_account = alicloud.log_archive_account
  }

  delivery_to_sls                  = var.delivery_to_sls
  sls_project_name_for_actiontrail = var.sls_project_name_for_actiontrail
  sls_project_description          = var.sls_project_description
  sls_project_tags                 = var.sls_project_tags
  delivery_to_oss                  = var.delivery_to_oss
  oss_bucket_name_for_actiontrail  = var.oss_bucket_name_for_actiontrail
  oss_bucket_tags                  = var.oss_bucket_tags
  actiontrail_trail_name           = var.actiontrail_trail_name
  actiontrail_trail_event_rw       = var.actiontrail_trail_event_rw
}
