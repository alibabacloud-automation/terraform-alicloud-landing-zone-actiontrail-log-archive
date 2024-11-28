terraform {
  required_version = ">= 0.13"
  required_providers {
    alicloud = {
      source                = "hashicorp/alicloud"
      version               = ">= 1.220.0"
      configuration_aliases = [alicloud.management_account, alicloud.log_archive_account]
    }
  }
}
