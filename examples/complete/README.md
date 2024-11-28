
# Complete

Configuration in this directory implements centralized centralization of multi-account operation logs, and archives the logs to SLS and OSS under the enterprise log archive account.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_archive"></a> [log\_archive](#module\_log\_archive) | ../../ | n/a |

## Resources

No resources.

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

No outputs.
<!-- END_TF_DOCS -->