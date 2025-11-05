

variable "environment" {
  description = "Environment identifier"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources (applied from root)"
  type        = map(string)
  default     = {}
}
