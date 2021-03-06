variable "finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences"
  type        = string

  default = "SIX_HOURS"
}

variable "member_account_email" {
  description = "AWS email address for member account"
  type        = string

  default = ""
}

variable "org_account_id" {
  description = "AWS account ID for the organisation account"
  type        = string

  default = ""
}

variable "org_detector_id" {
  description = "The ID of the GuardDuty detector in the default region of the organisation account"
  type        = string

  default = ""
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)

  default = {}
}
