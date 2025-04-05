variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
}

variable "uuid" {
  description = "A unique identifier that will be appended to resource names."
  type        = string
  default     = "asl-dataset-00" # Default value for the unique identifier
}