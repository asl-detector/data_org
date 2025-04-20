variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
}

variable "uuid" {
  description = "A unique identifier that will be appended to various names."
  type        = string
}

# Replace individual account variables with a single map of account IDs
variable "account_ids" {
  description = "Map of account IDs from AWS organization structure"
  type        = map(string)
}
