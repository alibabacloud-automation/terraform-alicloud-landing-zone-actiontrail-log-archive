Terraform module to implements Multi-Account Actiontrail Log Archive.

terraform-alicloud-landing-zone-actiontrail-log-archive
======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-landing-zone-actiontrail-log-archive/blob/main/README.md) | 简体中文

为满足外部审计及内部监管合规要求，在企业管理账号中使用资源目录进行多账号管理，并进行操作审计配置，能够统一收集所有账号操作日志。操作审计支持投递日志到SLS及OSS进行存储，SLS及OSS支持日志留存时间配置。

该Module会创建一个操作审计的跟踪，实现多账号操作日志中心化归集，将日志归集到企业日志账号下的SLS或OSS中。

架构图:
![diagram](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-landing-zone-actiontrail-log-archive/main/scripts/diagram-cn.jpg)

## 用法
您可以通过以下步骤在您的 terraform 模板中使用它。
```hcl
provider "alicloud" {
  alias  = "management_account"
  region = "cn-shanghai"
}

provider "alicloud" {
  alias  = "log_archive_account"
  region = "cn-shanghai"
}

module "log_archive" {
  source = "alibabacloud-automation/landing-zone-actiontrail-log-archive/alicloud"

  providers = {
    alicloud.management_account  = alicloud.management_account
    alicloud.log_archive_account = alicloud.log_archive_account
  }

  delivery_to_sls            = true
  delivery_to_oss            = true
  actiontrail_trail_name     = "muti-account-trail"
  actiontrail_trail_event_rw = "ALL"
}
```

## 示例
* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-landing-zone-actiontrail-log-archive/tree/main/examples/complete)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud.log_archive_account"></a> [alicloud.log\_archive\_account](#provider\_alicloud.log\_archive\_account) | >= 1.220.0 |
| <a name="provider_alicloud.management_account"></a> [alicloud.management\_account](#provider\_alicloud.management\_account) | >= 1.220.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_actiontrail_trail.trail](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/actiontrail_trail) | resource |
| [alicloud_log_project.actiontrail](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_oss_bucket.actiontrail](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_acl.actiontrail](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/oss_bucket_acl) | resource |
| [alicloud_ram_role.actiontrail](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach_policy](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.logarchive](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_account.management](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_log_service.enable_sls_service](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/log_service) | data source |
| [alicloud_oss_service.enable_oss_service](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/oss_service) | data source |
| [alicloud_regions.sls_project_region](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actiontrail_trail_event_rw"></a> [actiontrail\_trail\_event\_rw](#input\_actiontrail\_trail\_event\_rw) | Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default to All. | `string` | `"All"` | no |
| <a name="input_actiontrail_trail_name"></a> [actiontrail\_trail\_name](#input\_actiontrail\_trail\_name) | The name of the trail to be created, which must be unique for an account. | `string` | `"muti-account-actiontrail"` | no |
| <a name="input_delivery_to_oss"></a> [delivery\_to\_oss](#input\_delivery\_to\_oss) | Whether to delivery logs to oss. | `bool` | `true` | no |
| <a name="input_delivery_to_sls"></a> [delivery\_to\_sls](#input\_delivery\_to\_sls) | Whether to delivery logs to sls. | `bool` | `true` | no |
| <a name="input_oss_bucket_name_for_actiontrail"></a> [oss\_bucket\_name\_for\_actiontrail](#input\_oss\_bucket\_name\_for\_actiontrail) | The name of the oss bucket used for archiving ActionTrail logs. If omitted, ActionTrail logs won't be archived to oss. | `string` | `null` | no |
| <a name="input_oss_bucket_tags"></a> [oss\_bucket\_tags](#input\_oss\_bucket\_tags) | A mapping of tags to assign to the oss bucket used for archiving ActionTrail logs. | `map(string)` | <pre>{<br/>  "landingzone": "logarchive"<br/>}</pre> | no |
| <a name="input_sls_project_description"></a> [sls\_project\_description](#input\_sls\_project\_description) | The description of sls project used for archiving ActionTrail logs. | `string` | `null` | no |
| <a name="input_sls_project_name_for_actiontrail"></a> [sls\_project\_name\_for\_actiontrail](#input\_sls\_project\_name\_for\_actiontrail) | Sls project used for archiving ActionTrail logs. If omitted, ActionTrail logs won't be archived to sls. | `string` | `null` | no |
| <a name="input_sls_project_tags"></a> [sls\_project\_tags](#input\_sls\_project\_tags) | A mapping of tags to assign to the sls project used for archiving ActionTrail logs. | `map(string)` | <pre>{<br/>  "landingzone": "logarchive"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oss_bucket_id"></a> [oss\_bucket\_id](#output\_oss\_bucket\_id) | The OSS bucket to which the trail delivers logs. |
| <a name="output_oss_enable_status"></a> [oss\_enable\_status](#output\_oss\_enable\_status) | The current oss enable status. |
| <a name="output_sls_enable_status"></a> [sls\_enable\_status](#output\_sls\_enable\_status) | The current log service enable status. |
| <a name="output_sls_project_arn"></a> [sls\_project\_arn](#output\_sls\_project\_arn) | The SLS project to which the trail delivers logs. |
| <a name="output_trail_id"></a> [trail\_id](#output\_trail\_id) | The id of ActionTrail Trail. The value is the same as trail\_name. |
<!-- END_TF_DOCS -->

## 提交问题

如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
