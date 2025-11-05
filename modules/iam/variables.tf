

variable "environment" {
  description = "Environment identifier"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources (configured in root file)"
  type        = map(string)
  default     = {}
}
