variable "delivery_to_sls" {
  type        = bool
  default     = true
  description = "Whether to delivery logs to sls."
}

variable "sls_project_name_for_actiontrail" {
  type        = string
  default     = null
  description = "Sls project used for archiving ActionTrail logs. If omitted, ActionTrail logs won't be archived to sls."
}

variable "sls_project_description" {
  type        = string
  default     = null
  description = "The description of sls project used for archiving ActionTrail logs."
}

variable "sls_project_tags" {
  type = map(string)
  default = {
    "landingzone" : "logarchive"
  }
  description = "A mapping of tags to assign to the sls project used for archiving ActionTrail logs."
}

variable "delivery_to_oss" {
  type        = bool
  default     = true
  description = "Whether to delivery logs to oss."
}

variable "oss_bucket_name_for_actiontrail" {
  type        = string
  default     = null
  description = "The name of the oss bucket used for archiving ActionTrail logs. If omitted, ActionTrail logs won't be archived to oss."
}

variable "oss_bucket_tags" {
  type = map(string)
  default = {
    "landingzone" : "logarchive"
  }
  description = "A mapping of tags to assign to the oss bucket used for archiving ActionTrail logs."
}

variable "actiontrail_trail_name" {
  type        = string
  default     = "muti-account-actiontrail"
  description = "The name of the trail to be created, which must be unique for an account."
}

variable "actiontrail_trail_event_rw" {
  type        = string
  default     = "All"
  description = "Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default to All."
}