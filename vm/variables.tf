variable "region" {
  description = "GCP region"
  type        = string
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "example"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "prod"
}

variable "os_user" {
  description = "OS user"
  type        = string
  default     = "ubuntu"
}
