output "trail_id" {
  description = "The id of ActionTrail Trail. The value is the same as trail_name."
  value       = alicloud_actiontrail_trail.trail[*].id
}

output "sls_project_arn" {
  description = "The SLS project to which the trail delivers logs."
  value       = local.actiontrail_sls_project_arn
}

output "oss_bucket_id" {
  description = "The OSS bucket to which the trail delivers logs."
  value       = alicloud_oss_bucket.actiontrail[*].id
}

output "sls_enable_status" {
  description = "The current log service enable status."
  value       = data.alicloud_log_service.enable_sls_service[*].status
}

output "oss_enable_status" {
  description = "The current oss enable status."
  value       = data.alicloud_oss_service.enable_oss_service[*].status
}